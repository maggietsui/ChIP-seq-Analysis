#Loop through bamfiles in a directory and print total reads in the file

dir=
suffix=".bam"

find "$dir" -name "$suffix" |
        while read filename
        do
                #Ignore CTRL files
                if echo $filename | grep -q "CTRL"; then
                        continue
                fi
                #Print the donor ID
                echo -n $filename | awk -F'[_]' '{printf $5"_"$6"_"$7"_"$8}' >> tot_reads_bam.txt
                echo -n -e "\t" >> tot_reads_bam.txt
                samtools view -c $filename >> tot_reads_bam.txt

        done
