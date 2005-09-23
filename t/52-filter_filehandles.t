# Pod::WikiDoc - check module loading and create testing directory

use Test::More;
use File::Temp;
use t::Casefiles;

use Pod::WikiDoc;

#--------------------------------------------------------------------------#
# parser setup
#--------------------------------------------------------------------------#

my $parser = Pod::WikiDoc->new ();

#--------------------------------------------------------------------------#
# case file runner
#--------------------------------------------------------------------------#

my $cases = t::Casefiles->new( "t/filter_pod" );

$cases->run_tests( 
    sub { 
        my $input_string = shift;

        # setup output file
        my $output_file = File::Temp->new();

        # setup input file
        my $input_file = File::Temp->new();
        print $input_file $input_string;
        seek $input_file, 0, 0;

        # process input to output
        $parser->filter( { input => $input_file, output => $output_file } );

        # recover output for testing
        seek $output_file, 0, 0;
        my $got = do { local $/; <$output_file> };
        $got =~ s{\A [^\n]+ \n \n}{}xms; # strip "Generated by" line
        return $got;
    }
);
