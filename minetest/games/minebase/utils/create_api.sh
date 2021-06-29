files=$(find ../mods/ -name "api.md" | sort)

cat ../misc/api_start.md > ../api.md
echo >> ../api.md
cat ../misc/glossary.md >> ../api.md
echo >> ../api.md
for file in $files 
do
	cat $file >> ../api.md
	echo >> ../api.md
done
