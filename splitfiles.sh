tail -n +2 train.csv | split -l 1000000 - train_
for file in train_*
do
    head -n 1 train.csv > header
    cat $file >> header
    mv -f header $file
done