package HelloWorld::Controller::Example;
use Mojo::Base 'Mojolicious::Controller';
use SVG::Calendar;

# This action will render a template
sub welcome {
  my $self = shift;

  # Render template "example/welcome.html.ep" with message
  $self->render(msg => 'Welcome to the Mojolicious real-time web framework!');
}

sub who {
  my $self = shift;
  $self->render(who => [`ps -ef | grep vikramk`]);
}

sub cal {
  my ($c) = @_;
  my $svg = SVG::Calendar->new( page => 'A4' );
  my $mon = $c->param('mon') || '10';
  $mon = sprintf("%02d", $mon);
  my $year = $c->param('year') || '2019';
  my $dt = "$year-$mon";
  $c->render(data => $svg->output_month( $dt ), format => 'svg');
}

sub cal_form {
  my ($c) = @_;
  my @months = qw/Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec/;
  my $idx = 0;
  my $all_months = [ map { [ $_ => ++$idx ] } @months ];
  my $mon = $c->param('mon') || 01;
  my $year = $c->param('year') || 2019;
  $c->stash('months_for_select', $all_months);
  $c->stash('cal_img', "/cal.svg?mon=$mon&year=$year");
  $c->render;
}

sub run {
  my $c = shift;
  my $cmd = $c->param('cmd');
  $c->stash(result => [qx/$cmd/]);
  $c->render;
}

1;
