#!/usr/bin/perl
# Align all FASTA files in a folder using mafft.
#
# Copyright (c) 2013, Bryan White, bpcwhite@gmail.com

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
use FindBin;
use lib "$FindBin::Bin/libs/";
use General::Arguments;
use Sequence::PairwiseAlign;


use strict;
use warnings;

my $params = General::Arguments->new(	arguments_v => \@ARGV,
										option_defs => {'-outp'		=> 'output',	# Output prefix
														'-folder'	=> '',			# 
													}
													);

my $output_prefix	= $params->options->{'-outp'};
my $folder			= $params->options->{'-folder'};

my @alignments = <$folder/*.fas>;

foreach my $alignment_path (@alignments) {
	print $alignment_path."\n";
	my @alignment_file_split = split("/",$alignment_path);
	my $alignment_file = $alignment_file_split[-1];
	my $output_file = $folder.'/'.$output_prefix.'_'.$alignment_file;
	print $output_file."\n";
	my $mafft_string = "mafft --auto --preservecase --adjustdirection $alignment_path > $output_file";
	print "Calling $mafft_string\n";
	system($mafft_string);
}
