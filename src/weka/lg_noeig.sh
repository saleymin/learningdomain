#!/bin/bash
fileName="../matrices/properties.csv"

declare -i outputNum
outputNum=`ls outputs | sort -n | tail -n 1`
outputNum=outputNum+1


outputDir="outputs/$outputNum"
tempFile="$outputDir/temp.arff"

alias weka="java -cp /disk2/home/suleyman/software/weka-3-6-13/weka.jar"

if [ ! -d "$outputDir" ]; then
	mkdir $outputDir
fi

if [ -f $tempFile ]; then
	rm $tempFile
fi

cat attributes.arff $fileName > $tempFile

java -cp /disk2/home/suleyman/software/weka-3-6-13/weka.jar  weka.filters.unsupervised.attribute.Remove -R first-3,5,6,13-14,20-38 -i $tempFile -o  "$outputDir/data_00.arff" 

java -cp /disk2/home/suleyman/software/weka-3-6-13/weka.jar  weka.classifiers.trees.J48 -C 0.25 -M 2 -t "$outputDir/data_00.arff" -i  >& $outputDir/all_J48.out

java -cp /disk2/home/suleyman/software/weka-3-6-13/weka.jar weka.classifiers.rules.PART  -B -M 2 -C 0.25 -Q 1 -o -i -t "$outputDir/data_00.arff" >& $outputDir/all_PART.out


for cnt in `seq 26 38`; do
	
	columns=",13-14"
	if [ $cnt -eq 21 ] ; then
		columns="$columns,20"
	elif [ $cnt -gt 21 ] ; then
		let t1=cnt-1
		columns="$columns,20-$t1"
	fi

	if [ $cnt -eq 38 ] ; then
		columns="$columns,39"
	else 
		let t2=cnt+1
		columns="$columns,$t2-39"
	fi


	dataFile="$outputDir/data_$cnt.arff"
	comAtt="-o -i -t $dataFile"

	java -cp /disk2/home/suleyman/software/weka-3-6-13/weka.jar weka.filters.unsupervised.attribute.Remove -R "first-3,5,6$columns" -i $tempFile -o "$dataFile" 

	java -cp /disk2/home/suleyman/software/weka-3-6-13/weka.jar weka.classifiers.functions.SimpleLogistic -I 0 -M 500 -H 50 -W 0.0 $comAtt >& $outputDir/SL_$cnt.out

	java -cp /disk2/home/suleyman/software/weka-3-6-13/weka.jar weka.classifiers.trees.J48 -C 0.25 -M 2 $comAtt >& $outputDir/J48_$cnt.out 

	java -cp /disk2/home/suleyman/software/weka-3-6-13/weka.jar weka.classifiers.rules.DecisionTable -X 1 -S "weka.attributeSelection.BestFirst -D 1 -N 5" -R $comAtt >& $outputDir/DT_$cnt.out
	
	java -cp /disk2/home/suleyman/software/weka-3-6-13/weka.jar weka.classifiers.rules.DTNB -X 1 -R $comAtt >& $outputDir/DTNB_$cnt.out

	java -cp /disk2/home/suleyman/software/weka-3-6-13/weka.jar weka.classifiers.rules.JRip -F 3 -N 2.0 -O 2 -S 1 $comAtt >& $outputDir/Jrip_$cnt.out
	
	java -cp /disk2/home/suleyman/software/weka-3-6-13/weka.jar weka.classifiers.rules.OneR -B 6 $comAtt >& $outputDir/oneR_$cnt.out

	java -cp /disk2/home/suleyman/software/weka-3-6-13/weka.jar weka.classifiers.rules.PART -M 2 -C 0.25 -Q 1 $comAtt >& $outputDir/PART_$cnt.out

	java -cp /disk2/home/suleyman/software/weka-3-6-13/weka.jar weka.classifiers.rules.Ridor -F 3 -S 1 -N 2.0 $comAtt >& $outputDir/Ridor_$cnt.out

	#logistic ekle
	#diger iyi sonuc gosterenleri ekle
	echo "logistic regression $cnt completed"
	sleep 0.2
done

#rm data.arff
