#!C:/Strawberry/perl/bin/perl.exe

use strict;
use warnings;
use Data::Dumper;
use Getopt::Long;

my ($filename, $shld_cnt_words, $shld_cnt_chars);
my $USAGE="./character_histogram.pl [-c|-w] <filename>\n";

sub count_words
{
	my ($line) = @_;
	our (%elem_count, $elem);
	foreach $elem ($line =~ /\w+/g)
	{
		$elem_count{$elem}++;
	}
}

sub count_chars
{
	my ($line) = @_;
	our (%elem_count, $elem);
	foreach $elem (split(//, $line) )
	{
		$elem_count{$elem}++ if $elem =~ /[[:alpha:]]/;
	}
}

sub count_elems
{
	my ($process) = @_;
	our (%elem_count, $elem);
	while (my $line = <FH>)
	{
		chomp $line;
		$line = lc($line);
		&$process($line);
	}
	return %elem_count;
}

sub print_count_hash
{
	my (%count_hash) = @_;
	my $key;
	foreach $key (reverse sort { $count_hash{$a} <=> $count_hash{$b} } keys %count_hash)
	{
		printf("%s %s\n", $key, $count_hash{$key});
	}
}

sub main
{
	open (FH, $filename) or die "$filename could not be opened";

	if (defined $shld_cnt_words)
	{
		&print_count_hash(&count_elems(\&count_words));
	}
	seek(FH, 0, 0);

	if (defined $shld_cnt_chars)
	{
		&print_count_hash(&count_elems(\&count_chars));
	}
}

sub process_args
{
	my (@cmd_line_args) = @_;

	foreach my $arg (@cmd_line_args)
	{
		# if it starts with a -, then it is an option
		# if it is an option, then it has to have one of the valid characters: c, w
		# if it is not an option, then it is the name of the file to be processed
		if ($arg =~ m/^-/)
		{
			if ($arg eq "-c")
			{
				$shld_cnt_chars = 1;
			}
			if ($arg eq "-w")
			{
				$shld_cnt_words = 1;
			}
			if ($arg eq "-cw" || $arg eq "-wc")
			{
				$shld_cnt_words = $shld_cnt_chars = 1;
			}
		}
		else
		{
			$filename = $arg;
		}
	}

	#Check if at least one of the processing options is chosen
	if (! defined $shld_cnt_words && ! defined $shld_cnt_chars)
	{
		die $USAGE;
	}

	if (!defined($filename))
	{
		die $USAGE;
	}
}

&process_args(@ARGV);
&main;

