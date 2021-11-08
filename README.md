# hsp60ECCtool
This script allows to get Enterobacter cloacae complex hsp60 cluster from a multi-Fasta file.

# Dependencies
Perl programming language and [NCBI-Blast+](https://www.ncbi.nlm.nih.gov/books/NBK279690/) are needed to run the proram.
If you are using Linux Ubuntu/Debian, you can use the following command to install NCBI-Baslt+:
```
sudo apt update
sudo apt install ncbi-blast+
```

# How to use the tool
The script can be used as follows (the first argument is the input file, the second argument is the database file used by Blast, and the last argument is the %identity used to filter Blast output):
```
perl hsp60ECCtool.pl input_example.fasta database.fasta 80.00
```
The program will generate a result.tsv file with information on ECC clades found, and a blastOut file (output produced by blast)

# Description
hsp60ECCtool is a program dedicated to Enterobacter cloacae complex (ECC) that detects and identifies the partial coding sequence of hps60. It is based on the BLASTn algorithm and a specific dataset (based on sorted hsp60 sequences collected from GenBank ECC assemblies). The program helps users to clearly identify the hsp60 cluster and associated members of the Enterobacter cloacae complex.

- The tested strain(s) must be identified as belonging to the complex by a traditional method (API 20E, mass spectrometry...) before hsp60 typing.
- Partial amplification of the gene coding for hsp60 should be performed according to the initiale approach proposed by Hoffmann H. and Roggenkamp A. (2003).
- Hsp60 cluster assignment was done according to the original research article and additional analysis provided by Berouthy R. et al. (2018) and Pot M. et al. (2021).
- Associated species names are given according to Sutton GG. et al. (2018) and Wu W. et al. (2020).
- Best results are given in the hsp60ECCtool Result output. UD : Undefined Cluster (see in Figure S1 in the supplementary material provided by Pot M. et al. (2020)); NA : - Not Attributed in the related research paper. Without whole-genome sequencing and additional analyses, the precise species identification remains indicative and should be taken with caution.
