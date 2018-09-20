#!/usr/bin/perl
#
# This program reads a list of .m files from stdin, tries to
# add a copyright notice read from a file named "copyright".
#
# The assumption is that a file will consist of: 
# 1. some blank lines
# 2. some non-comment lines
# 3. some comment lines
# 4. a blank line, then a copyright notice 
# ... which we should insert if not present
# 5. rest of the file
# 
# note the use of the pattern "%%(C)" to identify the 
# beginning and end of the copyright notice


$cpattern="^[%][%][(]C[)]"; # this pattern identifies both beginning and end of copyright notice
$debug=0;
$tmpfile=".copyright.tmp.$$";

$copyright_file="copyright";
$update=0;
sub usage {
  print STDERR "ERROR: $_[0]\n";
  print STDERR "usage: $0 [opt] file ... \n";
  print STDERR "   or: find . -name '*.m' | $0 [opt]\n\n";
  print STDERR "opt:[-f copyright_file] [--update]\n";
  print STDERR "Default: copyright_file = \"$copyright_file\"\n";
  print STDERR "Update: if disabled (default), does not rewrite copyright notices of \n";
  print STDERR "        files which already have one.\n";
  exit(1);
  }

while (($opt=shift (@ARGV)) =~ /^-/ ) {
  if ($opt eq "-f") {
    $copyright_file = shift(@ARGV);
  }
  elsif ($opt eq "--update") {
    $update=1;
  }
  else {
    usage("Illegal option: $opt");
  }
}

# 1: read copyright
open C,"<$copyright_file";
@cnote=();
while (<C>) {
  push @cnote,$_;
  print $_ if ($debug);
}
close C;
if (defined($opt)) {
  foreach $file ($opt, @ARGV) {
    add_copyright($file);
  }
}
else {
  while (<>) {
    chomp;
    $file=$_;
    add_copyright($file);
  }
}

sub add_copyright {
  $file=$_[0];
  print "Processing ($file):\n" if ($debug);
  $state=0;
  open F,"<$file" or die "can't open $file";
  # first pass: scan for copyright
  unless ($update) {
    while (<F>) {
      if (/$cpattern/) {
	print "$file: already has a copyright notice.\n";
	close F;
	return 0;
      }
    }
  }
  #rewind(F);
  close F;
  open F,"<$file" or die "can't open $file";
  # second pass: insert copyright, deleting previous as needed
  open O,">$tmpfile" or die "can't open temporary file $tmpfile";
  $cnotefound=0;
  $linecount=0;
  while (<F>) {
    $linecount++;
    print "$file $linecount($state)$_" if ($debug);
    if ($state==0) {
      # state 0: looking for first non-empty, non continuation line.
      print O $_;
      $state=1 unless (/^[ \t]*$/ or /\.\.\.[ \t]*$/);
    }
    elsif ($state==1) {
      # state 1: looking for first non-comment line.
      if (/^[ \t]*[%]/) {
	# isa comment, print and stay in state
	print O $_;
      }
      else {
	print O "\n";
	foreach $line (@cnote) {
	  print O $line;
	}
	# restore the line that was originally here, unless blank
	print O $_ unless (/^[ \t]*$/);
	$state=103;
      }
    }
    elsif ($state == 103) {
      # after copyright
      if ( /$cpattern/) {
        print "$file: skipping previous copyright notice\n";
	$state=104;
	$cnotefound++;
      }
      else {
	print O $_;
      }
    }
    elsif ($state ==104) {
      # we're inside old copyright notice, skipping
      if (/$cpattern/) {
	$state=103;
      }
    }
    else {
     die "$0: Internal error, bad state $state\n";
   }
  }
  close O;
  close F;
  if ($state <100) {
    print STDERR "Error: $file: no copyright inserted, didn't know where to put it\n";
  }
  elsif ($state == 104) {
    print STDERR "Warning: $file: ends inside a previous copyright notice\n";
  }
  elsif ($state != 103) {
    die "file: ended in illegal state $state";
  }
  else {
    # valid state(103), copyright inserted.
    unlink "$file~";
    rename "$file","$file~" or die "can't rename $file to $file~, aborting!";
    rename "$tmpfile","$file" or die "can't rename $tmpfile to $file, aborting!";
    print "$file: added copyright notice, original saved in $file~\n";
    if (0) {
      $cmd="diff $file $tmpfile > /dev/null";
      # print "$cmd\n";
      $status=system($cmd);
      $status=$status/256;
      if ($status == 0) { # no differences
	print "$file: no differences.\n";
      }
      elsif ($status ==2) { #trouble
	die "$file: Error when checking differences";
      }
      elsif ($status == 1) { #differences
      }
      unlink("$file~");
      link($file,"$file~") or die "can't link $file $file~";
      unlink ($file) or die "can't unlink $file";
      link("$tmpfile",$file) or die "can't link $tmpfile, $file!! Restore from $file~";
      unlink "$tmpfile" or die "can't unlink $tmpfile!";
      print "$file: modified.\n";
    }
  }
}
print "$0: Finished.\n";


    
      
