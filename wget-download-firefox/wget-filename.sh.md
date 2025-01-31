# wget-filename.sh

- [X] @ArcPROGRAMM @DOWNLOAD **[../wget-filename.sh](./wget-filename.sh)**

Text creation time:
Di [Zettelkasten:2021:04:20]()
Modification time:
Di [Zettelkasten:2021:04:20]()
Uplink
[wget-download-firefox](../wget-download-firefox.md)

```bash
	wget -U "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)" --server-response -q -O - "https://arxiv.org/pdf/1607.00916" 2>&1 | 
	  grep "Content-Disposition:" | tail -1 | 
	  awk 'match($0, /filename=(.+)/, f){ print f[1] }'
	  
	wget -U "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)" --server-response -q -O - "https://arxiv.org/pdf/1607.00916" 2>&1 | 
	  grep "Location:" | tail -1 | 
	  awk 'match($0, /filename=(.+)/, f){ print f[1] }'
```
	
*wget-filename.sh*
```bash
#!/bin/bash
folder=$(date +"/home/christian/AEI/Zettelkasten/%Y/%m/%d")
cd $folder
File=$(wget --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0)" $1 2>&1 | grep Saving | cut -d ' ' -f 3 | sed -e 's/[^A-Za-z0-9._-]//g')
wget --no-use-server-timestamps --user-agent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:88.0)" -O $File $1
tt $File $1

```

