#!/usr/bin/perl
# assume the file is sotred by counts. i.e. by last field
#62 124609 1
# idea: go over sorted file, and for each gene in each cell assgin the rank ($numGenes=most expressed,$numGenes-1=2nd most expressed etc.)
# for each gene sum all the ranks
# and output the list of genes sorted by rank

$numGenes=33538; # number of genes in the dataset
open($out,'>',$ARGV[1]);
open($out_num_cell,'>',$ARGV[2]);

my $Fname_in_data =$ARGV[0];
open($fh,'<',$Fname_in_data) or die "failed to open file";
chomp ( my @file = <$fh>);
close ($fh);
$L=scalar(@file);
my %rank_bank,%total_ranks,%total_cell_expressed;
for ($i=0;$i<$L;$i++) { 
	@tabs = split(/ /,$file[$i]);	
	$cur_cell=$tabs[1]; # cell number
	$cur_gene_num=$tabs[0]; # gene number

  	if(!exists($rank_bank{$cur_cell})) { # new cell
		$rank_bank{$cur_cell}=$numGenes; 
	}
	
	if(!exists($total_ranks{$cur_gene_num})) { # new gene
		$total_ranks{$cur_gene_num}=$rank_bank{$cur_cell};
		$total_cell_expressed{$cur_gene_num}=1; # number of cells in which the gene is expressed
	}
	else {
		$total_ranks{$cur_gene_num}=$total_ranks{$cur_gene_num}+$rank_bank{$cur_cell};
		$total_cell_expressed{$cur_gene_num}=$total_cell_expressed{$cur_gene_num}+1; 
	}
	$rank_bank{$cur_cell}=$rank_bank{$cur_cell}-1;
}

# go over total_ranks and print the genenum(keys) sorted by the total_ranks
foreach my $gn (sort { $total_ranks{$b} <=> $total_ranks{$a} } keys %total_ranks) {
    print $out "$gn\t$total_ranks{$gn}\t$total_cell_expressed{$gn}\n";
}
$s=keys %rank_bank; # number of cells
print $out_num_cell "$s\n";

close($out);
close($out_num_cell);

print STDOUT "$ARGV[1]\n";
foreach my $gn (keys %total_ranks) {
	print STDOUT "$gn\n";
}
