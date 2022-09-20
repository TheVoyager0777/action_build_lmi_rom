MODDIR=${0%/*}
ROM=ROM_name
cat $MODDIR/"${ROM}"* > $MODDIR/"${ROM}"
RealMd5=$(echo $MODDIR/"${ROM}" | cut -d '_' -f 4)
echo "- ROM正确的MD5值为: $RealMd5"
echo
LocalMd5=$(md5sum $MODDIR/"${ROM}" | head -c10)
echo "- ROM经校验MD5值为: $LocalMd5"
echo
if [[ $LocalMd5 = $RealMd5 ]];then
echo "- ROM，MD5值正确，可以刷入"
else
echo "- ROM检验错误，请检查是否下载错误"
fi
