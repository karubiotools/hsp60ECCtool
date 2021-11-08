#!/usr/bin/perl

use strict;
use warnings;
#use Bio::SeqIO;

#parameters
my $input = $ARGV[0]; #Sequences input file
my $database = $ARGV[1]; #database
my $ident = $ARGV[2]; # percentage identity
my @arrayID = ();
my $output = "result.tsv"; # $ARGV[3] (used for XML Galaxy) 
my $blastFile = "blastOut"; #output of BLAST ($ARGV[4] used for XML Galaxy)

if (-e $input and -e $database){
  #create database with makeblastdb
  `makeblastdb -in $database -dbtype nucl`;
  #blastn
  `blastn -query $input -db $database -perc_identity $ident -task 'megablast' -evalue '0.001' -out $blastFile -outfmt '6 std sallseqid score nident positive gaps ppos qfr
ame sframe qseq sseq qlen slen salltitles'`;
}

#my $blastFile = "$input.blastOut"; #output of BLAST


#my $seqIO = Bio::SeqIO->new(-format=>'Fasta', -file=>$input);

#while (my $seq = $seqIO->next_seq()) {
  #my $seqID = $seq->id;
  #my $seqNuc = $seq->seq;
  #push @arrayID, $seqID;
  #$hSeq{$seqID} = $seqNuc;
  #my @seqArray = split //, $seqNuc;
#}

open (GS, $input) or die $!;

while (my $line = <GS>) {
  if ($line =~ />([\w\.]*)\s/){
    my $current_id = $1; #we retrieve the name
    push @arrayID, $current_id;
  }
}


#Print final result
open (OUT, '>', $output) or die $!;
print OUT "SequenceID\tHsp60 Cluster\tSutton GG et al. associated species and clade\tWu W et al. associated species or taxon\t% identity\tReference assembly\n";
#header, Hsp60 Cluster  Sutton GG et al. associated species and clade   Wu W et al. associated species or taxon %      identity Reference assembly

foreach my $elem (@arrayID) {

  my $line = `grep '$elem' '$blastFile' | head -n 1`;
  #split line
  if($line){
    my @tab1 = split(/\t/, $line);
    my $bigString = $tab1[1]; #cluster elements
    my @tab2 = split(/__/, $bigString);
    my $assembly = $tab2[3]; #assembly
    $assembly =~ tr/_/\./;

    print OUT "$elem\t$tab2[0]\t$tab2[1]\t$tab2[2]\t$tab1[2]\t$assembly\n";
  }
  else{
    print OUT "$elem\tNA\tNA\tNA\tNA\tNA\n";
  }

}

#print "First line = $line\n\n";

#$line = `grep '$arrayID[1]' '$blastFile' | head -n 1`;
#print "Second line is  = $line\n";


#unlink glob "*fa*";
#unlink glob "*blast*";


close (OUT);
#close(E);

