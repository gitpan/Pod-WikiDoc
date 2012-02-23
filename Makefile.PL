
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Generate Pod from inline wiki style text",
  "AUTHOR" => "David A Golden <dagolden\@cpan.org>",
  "BUILD_REQUIRES" => {
    "Cwd" => 0,
    "File::Basename" => 0,
    "File::Find" => 1,
    "File::Spec" => 3,
    "File::Temp" => 0,
    "IPC::Run3" => "0.033",
    "Probe::Perl" => "0.01",
    "Test::Builder" => 0,
    "Test::More" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Pod-WikiDoc",
  "EXE_FILES" => [
    "bin/wikidoc"
  ],
  "LICENSE" => "apache",
  "NAME" => "Pod::WikiDoc",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Getopt::Lucid" => "0.14",
    "IO::String" => "1.06",
    "Parse::RecDescent" => "1.967006",
    "Pod::Usage" => 1,
    "Scalar::Util" => "1.02",
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.19",
  "test" => {
    "TESTS" => "t/*.t t/contributed/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



