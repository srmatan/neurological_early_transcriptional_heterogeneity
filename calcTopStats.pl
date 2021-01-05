#!/usr/bin/perl
###  print celltype\tgrade\tnumCells\tmedian\n

# usage: perl calcTopStats.pl $file $file_out $numCells 200
# go over file, take only first 200 rows and count 

$grade=$ARGV[4];
$cond=$ARGV[5];
open($out,'>>',$ARGV[1]);
$totalNumCells=$ARGV[2];
$top=$ARGV[3];

my $Fname_in_data =$ARGV[0];
open($fh,'<',$Fname_in_data) or die "failed to open file";
chomp ( my @file = <$fh>);
close ($fh);
$L=scalar(@file);
my @num_cells;
$sum=0;

if($L<$top) { # the number of top genes asked is too large
	print STDOUT "ERROR: top is greater then number of genes detected\n";
}
else {
for ($i=0;$i<$top;$i++) {
        @tabs = split(/\t/,$file[$i]);
	$cur_gene=$tabs[0];
	$num_cells[$i]=$tabs[2];
	$sum=$sum+$num_cells[$i];
}
$med=$num_cells[$top/2.0]; # median number of cells expressing a gene among the $top ranked genes 
$per=$med/$totalNumCells*100; # median percentage of cells expressing a gene among the $top ranked genes
print $out "$cond\t${grade}\t${totalNumCells}\t$per\n";
}
close($out);