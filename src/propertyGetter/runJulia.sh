SECONDS=0

#if [ -f /disk2/home/suleyman/works/matrices/properties*.csv ]; then
        rm /disk2/home/suleyman/works/matrices/properties*.csv
#fi



julia -p 48 main.jl
#julia  main.jl

rm /disk2/home/suleyman/works/matrices/temp.csv  

cat /disk2/home/suleyman/works/matrices/properties*.csv > /disk2/home/suleyman/works/matrices/temp.csv

rm /disk2/home/suleyman/works/matrices/properties*.csv

grep   "$(awk -F, '{a[$39]++;}END{for (i in a) if (a[i] > 39 ) { print i} }' "/disk2/home/suleyman/works/matrices/temp.csv")" "/disk2/home/suleyman/works/matrices/temp.csv"  > /disk2/home/suleyman/works/matrices/properties.csv

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
