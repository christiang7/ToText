#!/bin/bash
it=$(echo $LANG|cut -f1 -d_|grep it|wc -l);
fr=$(echo $LANG|cut -f1 -d_|grep fr|wc -l);
if [ "$it" -eq "1" ];
then
    TITLEPROGRESS="Creo file PDF";
    MSGALPHA="Rimozione canale alpha da";
    MSGPREPARING="Preparazione di";
    MSGWRITING="Scrittura di";
    TITLECANCEL="STOP!";
    MSGCANCEL="Operazione annullata come richiesto.";
    TITLEDONE="FATTO!";
    MSGDONE="Il tuo file è pronto.";
    TITLEERROR="ERRORE";
    MSGFOLDER="Impossibile accedere a";
elif [ "$fr" -eq "1" ];
then
    TITLEPROGRESS="Création du fichier PDF";
    MSGALPHA="Suppression du canal alpha depuis";
    MSGPREPARING="Préparation de";
    MSGWRITING="Écriture de";
    TITLECANCEL="STOP!";
    MSGCANCEL="Opération annulée comme demandé.";
    TITLEDONE="C'EST FAIT !";
    MSGDONE="Votre fichier est prêt.";
    TITLEERROR="ERREUR";
    MSGFOLDER="Impossible d'accéder à";
else TITLEPROGRESS="Creating PDF file";
    MSGALPHA="Ditching alpha channel from";
    MSGPREPARING="Preparing";
    MSGWRITING="Writing of";
    TITLECANCEL="STOPPED!";
    MSGCANCEL="Operation cancelled as requested.";
    TITLEDONE="DONE!";
    MSGDONE="Your file is ready.";
    TITLEERROR="ERROR";
    MSGFOLDER="No access to";
fi;
count=0;
for infile in %F;
do
    count=$((count+1));
    outdir=$(dirname "$infile");
done;
cd "$outdir" || kdialog --title "$TITLEERROR" --error "$MSGFOLDER $outdir"; outfile=$(kdialog --getsavefilename "$outdir" "application/pdf") || exit 1;
if [ $? -eq 0 ];
then
    outfile="${outfile%.*}.pdf";
    tmpdir="$(dirname "$outfile")/.img2pdf.$(date +%s)";
    mkdir "$tmpdir";
    if [ $? -eq 0 ];
    then
        count=$((count*100));
        progress=$(kdialog --title "$TITLEPROGRESS" --progressbar "" $(($count+1)));
        count="0";
        echo "$@"
        #lines="$(ls -1 "$@")"
        #echo $lines
        for infile in "$@";
        do
            cancel=0;
            echo $infile
            count=$((count+50));
            extens=${infile##*.};
            qdbus $progress Set "" value $count > /dev/null || cancel=1;
            if [ $cancel -eq 0 ];
            then
                tmpfile=$tmpdir/"$(printf "%08d" $count)_no-alpha_$(basename "$infile")";
                filename="${tmpfile%.*}"
                echo $filename
                if [ "$extens" == avif ];
                then
                    echo avif;
                    qdbus $progress setLabelText "$MSGPREPARING $(basename "$infile")" > /dev/null || cancel=1;
                    message=$(convert "$infile" "$filename".jpg 2>&1);
                elif [ $(identify -format '%[channels]' "$infile" |grep 'a'|wc -l) -gt 0 ];
                then
                    qdbus $progress setLabelText "$MSGALPHA $(basename "$infile")" > /dev/null || cancel=1;
                    message=$(convert "$infile" -background white -alpha remove -alpha off "$tmpfile" 2>&1);
                else
                    qdbus $progress setLabelText "$MSGPREPARING $(basename "$infile")" > /dev/null || cancel=1;
                    message=$(cp "$infile" "$tmpfile" 2>&1);
                fi;
                if [ $? -gt 0 ];
                then
                    kdialog --title "$TITLEERROR" --error "imagemagick: $message";
                    rm "$tmpfile" 2>/dev/null;
                fi;
            fi;
            count=$((count+50));
            qdbus $progress Set "" value $count > /dev/null || cancel=1;
            if [ $cancel -gt 0 ];
            then
                notify-send -i application-pdf -a "$TITLECANCEL" -t 6000 "$MSGCANCEL";
                rm -r "$tmpdir";
                qdbus $progress close > /dev/null;
                exit 1;
            fi;
        done;
    else
        kdialog --title "$TITLEERROR" --error "$MSGFOLDER $tmpdir";
        qdbus $progress close > /dev/null;
        exit 1;
    fi;
    cd "$tmpdir" || kdialog --title "$TITLEERROR" --error "$MSGFOLDER $tmpdir";
    if [ $? -gt 0 ];
    then
        rm -r "$tmpdir";
        qdbus $progress close > /dev/null;
        exit 1;
    fi;
    qdbus $progress setLabelText "$MSGWRITING $(basename "$outfile")" > /dev/null || cancel=1;
    if [ $cancel -gt 0 ];
    then
        notify-send -i application-pdf -a "$TITLECANCEL" -t 6000 "$MSGCANCEL";
        rm -r "$tmpdir";
        qdbus $progress close > /dev/null;
        exit 1;
    else
        message=$(img2pdf -o "$outfile" ./* 2>&1);
    fi;
    if [ $? -eq 0 ];
    then
        notify-send -i application-pdf -a "$TITLEDONE" -t 6000 "$MSGDONE";
    else
        kdialog --title "$TITLEERROR" --error "img2pdf: $message";
    fi;
    sleep 0,1;
    qdbus $progress close > /dev/null;
    cd ..;
    rm -r "$tmpdir";
fi;
pdf-small.sh "$outfile";
exit 0;