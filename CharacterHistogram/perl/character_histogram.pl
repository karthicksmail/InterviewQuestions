#!C:/Strawberry/perl/bin/perl.exe

use strict;
use warnings;
use Data::Dumper;
use Getopt::Long;

sub count_words
{
	my (%word_count, $word);
	while (my $line = <FH>)
	{
		chomp $line;
		$line = lc($line);
		foreach $word ($line =~ /\w+/g)
		{
			$word_count{$word}++;
		}
	}
	return %word_count;
}

sub count_chars
{
	my (%char_count, $char);
	while (my $line = <FH>)
	{
		chomp $line;
		$line = lc($line);
		foreach $char (split(//, $line) )
		{
			$char_count{$char}++ if $char =~ /[[:alpha:]]/;
		}
	}
	return %char_count;
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
	my ($filename, $shld_cnt_words, $shld_cnt_chars) = @_;

	open (FH, $filename) or die "$filename could not be opened";

	if ($shld_cnt_words eq "1")
	{
		&print_count_hash(&count_words());
	}

	if ($shld_cnt_chars eq "1")
	{
		&print_count_hash(&count_chars());
	}
}


#my ($filename, $shld_cnt_words, $shld_cnt_chars);
my $filename;

GetOptions( "words" => \( my $shld_cnt_words = "0"),
	    "chars" => \( my $shld_cnt_chars = "0")
	    );

&main($ARGV[-1], $shld_cnt_words, $shld_cnt_chars);

