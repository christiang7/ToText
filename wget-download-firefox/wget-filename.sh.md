# wget-filename.sh

* ☑ @ArcPROGRAMM @DOWNLOAD **[../wget-filename.sh](./wget-filename.sh)**

Text creation time:
Di [Zettelkasten:2021:04:20]()
Modification time:
Di [Zettelkasten:2021:04:20]()
Uplink
[wget-download-firefox](../wget-download-firefox.md)

	wget -U "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)" --server-response -q -O - "https://arxiv.org/pdf/1607.00916" 2>&1 | 
	  grep "Content-Disposition:" | tail -1 | 
	  awk 'match($0, /filename=(.+)/, f){ print f[1] }'
	  
	wget -U "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)" --server-response -q -O - "https://arxiv.org/pdf/1607.00916" 2>&1 | 
	  grep "Location:" | tail -1 | 
	  awk 'match($0, /filename=(.+)/, f){ print f[1] }'
	
	


