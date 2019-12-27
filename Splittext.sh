#!/bin/bash
FirstDel=$(ls -t *"MX"* | head -n 1)
SecondDel=$(ls -t *"mx"* | head -n 2)
echo $FirstDel
echo $SecondDel
sed -i -e "s/\(put \).*/\1$FirstDel/"  First_Deployment.txt
sed -i -e "s/\(put \).*/\1$SecondDel/"  Second_Deployment.txt