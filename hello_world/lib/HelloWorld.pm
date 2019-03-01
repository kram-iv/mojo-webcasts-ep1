package HelloWorld;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by config file
  my $config = $self->plugin('Config');

  # Configure the application
  $self->secrets($config->{secrets});

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');
  $r->get('/who')->to('example#who')->name('who');

  $r->get('/cal.svg')->to('example#cal');
  $r->get('/cal')->to('example#cal_form');

  $r->get('/prepare')->to('example#prepare')->name('home');
  $r->post('/exec_cmd')->to('example#exec_cmd');  
  #$r->post('/run')->to('example#run')->name('run');  
}

1;
