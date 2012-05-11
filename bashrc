ts(){

curl -s \
        "http://fanyi.youdao.com/translate?smartresult=dict&smartresult=rule&smartresult=ugc&sessionFrom=dict.top" \
     -d \
	"type=AUTO& i=$1&doctype=json&xmlVersion=1.4&keyfrom=fanyi.web&ue=UTF-8&typoResult=true&flag=false" \
        | sed -r -n 's/.*tgt":"([^"]+)".*/\1/p' ;

return 0;
}

ts2(){

result=`curl -s \
        "http://dict.cn/ws.php?utf8=true&q=$1" `;

result2=`echo  $result | sed -r -n 's/.*<def>([^<]+)<\/def>.*/\1/p'`; 
echo $result2;

#expamle
result2=`echo  $result | sed -r -n 's/.*<orig>([^<]+)<\/orig>.*/\1/p'`; 
#echo $result2

result2=`echo  $result2 | sed -r -n 's/([^&]+)&lt;em&gt;([^&]+)&lt;\/em&gt;(.*)/\1\2\3/p'`; 
echo $result2

#
#echo $result
result2=`echo  $result | sed -r -n 's/.*<trans>([^<]+)<\/trans>.*/\1/p'`; 
echo $result2

return 0;
}

