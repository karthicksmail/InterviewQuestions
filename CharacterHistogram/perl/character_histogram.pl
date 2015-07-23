#!C:/Strawberry/perl/bin/perl.exe

use strict;
use warnings;
use Data::Dumper;
use feature 'say';
use feature 'switch';

my ($filename, $shld_cnt_words, $shld_cnt_chars);
my ($op_format);
my $USAGE="./character_histogram.pl [-p[a|w]] [-o[c|w|uw|cw|cc]] <filename>\n";

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
		if ($elem =~ /[[:alpha:]]/)
		{
			$elem_count{$elem}++; #if $elem =~ /[[:alpha:]]/;
		}
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

sub format_for_print
{
#	my (%count_hash) = @_;
	my $format_sub_ref;
	if ($op_format == 0 || $op_format == 1)
	{
		$format_sub_ref = sub
					{
						my(%count_hash) = @_;
						my @keys = sort { $count_hash{$b} <=> $count_hash{$a} } keys %count_hash;
						return @keys;
					};
	}
	return $format_sub_ref;
}

sub print_hash
{
	my ($format_sub_ref, %hash) = @_;
	foreach my $key ($format_sub_ref->(%hash))
	{
#		print $key."\n";
		printf($key." ".$hash{$key}."\n");
	}
}

sub main
{
	open (FH, $filename) or die "$filename could not be opened";
	my %hash;

	if (defined $shld_cnt_words)
	{
		%hash = &count_elems(\&count_words);
	#	print("Size of hash: ".keys(%hash));
		&print_hash(&format_for_print(%hash), %hash);
	}
	seek(FH, 0, 0);

	if (defined $shld_cnt_chars)
	{
		%hash = &count_elems(\&count_chars);
		#print("Size of hash: ".keys(%hash));
		&print_hash(&format_for_print(%hash), %hash);
	}
}

sub process_args
{
	my (@cmd_line_args) = @_;

	foreach my $arg (@cmd_line_args)
	{
		# if it starts with a -, then it is an option
		# if it is an option, then it has to have one of the following: pa, pw, oc, ouw, ocw, occ
		# if it is not an option, then it is the name of the file to be processed
		#say ("---".$arg."---");
		if ($arg =~ m/^-/)
		{
			#say("-");
			if ($arg =~ m/^-p/)
			{
#				say("-p");
				if ($arg =~ m/a/)
				{
					#say("-pa");
					$shld_cnt_chars = 1;
				}
				if ($arg =~ m/w/)
				{
					#say("-pw");
					$shld_cnt_words = 1;
				}
#				if ($arg eq "-paw" || $arg eq "-pwa")
#				{
#					$shld_cnt_words = $shld_cnt_chars = 1;
#				}
			}
			elsif ($arg =~ m/^-o/)
			{
				say("-o");
				if ($arg =~ m/c/)
				{
					#say("-oc");
#					$op_chars = 1;
					$op_format = 0;
				}
				elsif ($arg =~ m/w/)
				{
					#say("-ow");
#					$op_words = 1;
					$op_format = 1;
				}
				elsif ($arg =~ m/uw/)
				{
					#say("-ouw");
#					$op_unique_words = 1;
					$op_format = 2;
				}
				elsif ($arg =~ m/cw/)
				{
					#say("-ocw");
#					$op_common_words = 1;
					$op_format = 3;
				}
				elsif ($arg =~ m/cc/)
				{
					#say("-occ");
#					$op_common_chars = 1;
					$op_format = 4;
				}
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

