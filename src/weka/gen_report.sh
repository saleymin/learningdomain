declare -i outputNum
outputNum=`ls outputs | sort -n | tail -n 1`
outputDir="outputs/$outputNum"

cd $outputDir

echo -e "Simple Logistic\n"

grep  -A 10 -H -n   "Stratified" SL_*.out | grep -i correctly |  awk -F'[-]' '{print substr($1,4,2) "\t" $3}' | awk -F' ' '{print $1 "\t" $2  "\t" $5 "\t" $6$7}'

echo -e "\n"
echo -e ' \tclassified as ' 
echo -e ' \ta\tb ' 

grep  -A 50 -H -n   "Stratified" SL_*.out | grep -A 2 "classi" |  grep -A 1  "56"   | grep -v -e '^--' | awk -F'[-]' '{print substr($1,4,2) "\t" $3}' | awk -F'|' '{print $1}' | awk -F' ' '{
if (NR % 2 == 1) letter="a";
else letter="b";
print $1 "\t" $2 "\t" $3 "\t" letter}'


echo -e "\n"
echo -e ' \tTP\tFP\tRecall ' 

grep  -A 50 -H -n   "Stratified" SL_*.out | grep -A 2 "TP Rate" | grep -A 1 "out-48" | grep -v -e '^--' | awk -F'[-]' '{print substr($1,4,2) "\t" $3}' | awk -F' ' '{print $1 "\t" $2 "\t" $3 "\t" $4}'


echo -e "\nJ48\n"

grep  -A 10 -H -n   "Stratified" J48_*.out | grep -i correctly |  awk -F'[-]' '{print substr($1,5,2) "\t" $3}' | awk -F' ' '{print $1 "\t" $2  "\t" $5 "\t" $6$7}'

echo -e "\n"
echo -e ' \tclassified as ' 
echo -e ' \ta\tb ' 

grep  -A 50 -H -n   "Stratified" J48_*.out | grep -A 2 "classi" |  grep -A 1  "56"   | grep -v -e '^--' | awk -F'[-]' '{print substr($1,5,2) "\t" $3}' | awk -F'|' '{print $1}' | awk -F' ' '{
if (NR % 2 == 1) letter="a";
else letter="b";
print $1 "\t" $2 "\t" $3 "\t" letter}'


echo -e "\n"
echo -e ' \tTP\tFP\tRecall ' 

grep  -A 50 -H -n   "Stratified" J48_*.out | grep -A 2 "TP Rate" | grep -A 1 "out-48" | grep -v -e '^--' | awk -F'[-]' '{print substr($1,5,2) "\t" $3}' | awk -F' ' '{print $1 "\t" $2 "\t" $3 "\t" $4}'


echo -e "\nDecision Table\n"

grep  -A 10 -H -n   "Stratified" DT_*.out | grep -i correctly |  awk -F'[-]' '{print substr($1,4,2) "\t" $3}' | awk -F' ' '{print $1 "\t" $2  "\t" $5 "\t" $6$7}'

echo -e "\n"
echo -e ' \tclassified as ' 
echo -e ' \ta\tb ' 

grep  -A 50 -H -n   "Stratified" DT_*.out | grep -A 2 "classi" |  grep -A 1  "56"   | grep -v -e '^--' | awk -F'[-]' '{print substr($1,4,2) "\t" $3}' | awk -F'|' '{print $1}' | awk -F' ' '{
if (NR % 2 == 1) letter="a";
else letter="b";
print $1 "\t" $2 "\t" $3 "\t" letter}'

echo -e "\n"
echo -e ' \tTP\tFP\tRecall ' 

grep  -A 50 -H -n   "Stratified" DT_*.out | grep -A 2 "TP Rate" | grep -A 1 "out-48" | grep -v -e '^--' | awk -F'[-]' '{print substr($1,4,2) "\t" $3}' | awk -F' ' '{print $1 "\t" $2 "\t" $3 "\t" $4}'

echo -e "\nDTNB\n"

grep  -A 10 -H -n   "Stratified" DTNB_*.out | grep -i correctly |  awk -F'[-]' '{print substr($1,6,2) "\t" $3}' | awk -F' ' '{print $1 "\t" $2  "\t" $5 "\t" $6$7}'

echo -e "\n"
echo -e ' \tclassified as ' 
echo -e ' \ta\tb ' 

grep  -A 50 -H -n   "Stratified" DTNB_*.out | grep -A 2 "classi" |  grep -A 1  "56"   | grep -v -e '^--' | awk -F'[-]' '{print substr($1,6,2) "\t" $3}' | awk -F'|' '{print $1}' | awk -F' ' '{
if (NR % 2 == 1) letter="a";
else letter="b";
print $1 "\t" $2 "\t" $3 "\t" letter}'


echo -e "\n"
echo -e ' \tTP\tFP\tRecall ' 

grep  -A 50 -H -n   "Stratified" DTNB_*.out | grep -A 2 "TP Rate" | grep -A 1 "out-48" | grep -v -e '^--' | awk -F'[-]' '{print substr($1,6,2) "\t" $3}' | awk -F' ' '{print $1 "\t" $2 "\t" $3 "\t" $4}'


echo -e "\nJrip\n"

grep  -A 10 -H -n   "Stratified" Jrip_*.out | grep -i correctly |  awk -F'[-]' '{print substr($1,6,2) "\t" $3}' | awk -F' ' '{print $1 "\t" $2  "\t" $5 "\t" $6$7}'

echo -e "\n"
echo -e ' \tclassified as ' 
echo -e ' \ta\tb ' 

grep  -A 50 -H -n   "Stratified" Jrip_*.out | grep -A 2 "classi" |  grep -A 1  "56"   | grep -v -e '^--' | awk -F'[-]' '{print substr($1,6,2) "\t" $3}' | awk -F'|' '{print $1}' | awk -F' ' '{
if (NR % 2 == 1) letter="a";
else letter="b";
print $1 "\t" $2 "\t" $3 "\t" letter}'


echo -e "\n"
echo -e ' \tTP\tFP\tRecall ' 

grep  -A 50 -H -n   "Stratified" Jrip_*.out | grep -A 2 "TP Rate" | grep -A 1 "out-48" | grep -v -e '^--' | awk -F'[-]' '{print substr($1,6,2) "\t" $3}' | awk -F' ' '{print $1 "\t" $2 "\t" $3 "\t" $4}'

echo -e "\nOneR\n"

grep  -A 10 -H -n   "Stratified" oneR_*.out | grep -i correctly |  awk -F'[-]' '{print substr($1,6,2) "\t" $3}' | awk -F' ' '{print $1 "\t" $2  "\t" $5 "\t" $6$7}'

echo -e "\n"
echo -e ' \tclassified as ' 
echo -e ' \ta\tb ' 

grep  -A 50 -H -n   "Stratified" oneR_*.out | grep -A 2 "classi" |  grep -A 1  "56"   | grep -v -e '^--' | awk -F'[-]' '{print substr($1,6,2) "\t" $3}' | awk -F'|' '{print $1}' | awk -F' ' '{
if (NR % 2 == 1) letter="a";
else letter="b";
print $1 "\t" $2 "\t" $3 "\t" letter}'

echo -e "\n"
echo -e ' \tTP\tFP\tRecall ' 

grep  -A 50 -H -n   "Stratified" oneR_*.out | grep -A 2 "TP Rate" | grep -A 1 "out-48" | grep -v -e '^--' | awk -F'[-]' '{print substr($1,6,2) "\t" $3}' | awk -F' ' '{print $1 "\t" $2 "\t" $3 "\t" $4}'


echo -e "\nPart\n"

grep  -A 10 -H -n   "Stratified" PART_*.out | grep -i correctly |  awk -F'[-]' '{print substr($1,6,2) "\t" $3}' | awk -F' ' '{print $1 "\t" $2  "\t" $5 "\t" $6$7}'

echo -e "\n"
echo -e ' \tclassified as ' 
echo -e ' \ta\tb ' 

grep  -A 50 -H -n   "Stratified" PART_*.out | grep -A 2 "classi" |  grep -A 1  "56"   | grep -v -e '^--' | awk -F'[-]' '{print substr($1,6,2) "\t" $3}' | awk -F'|' '{print $1}' | awk -F' ' '{
if (NR % 2 == 1) letter="a";
else letter="b";
print $1 "\t" $2 "\t" $3 "\t" letter}'


echo -e "\n"
echo -e ' \tTP\tFP\tRecall ' 

grep  -A 50 -H -n   "Stratified" PART_*.out | grep -A 2 "TP Rate" | grep -A 1 "out-48" | grep -v -e '^--' | awk -F'[-]' '{print substr($1,6,2) "\t" $3}' | awk -F' ' '{print $1 "\t" $2 "\t" $3 "\t" $4}'

echo -e "\nRidor\n"

grep  -A 10 -H -n   "Stratified" Ridor_*.out | grep -i correctly |  awk -F'[-]' '{print substr($1,7,2) "\t" $3}' | awk -F' ' '{print $1 "\t" $2  "\t" $5 "\t" $6$7}'

echo -e "\n"
echo -e ' \tclassified as ' 
echo -e ' \ta\tb ' 

grep  -A 50 -H -n   "Stratified" Ridor_*.out | grep -A 2 "classi" |  grep -A 1  "56"   | grep -v -e '^--' | awk -F'[-]' '{print substr($1,7,2) "\t" $3}' | awk -F'|' '{print $1}' | awk -F' ' '{
if (NR % 2 == 1) letter="a";
else letter="b";
print $1 "\t" $2 "\t" $3 "\t" letter}'


echo -e "\n"
echo -e ' \tTP\tFP\tRecall ' 

grep  -A 50 -H -n   "Stratified" Ridor_*.out | grep -A 2 "TP Rate" | grep -A 1 "out-48" | grep -v -e '^--' | awk -F'[-]' '{print substr($1,7,2) "\t" $3}' | awk -F' ' '{print $1 "\t" $2 "\t" $3 "\t" $4}'
