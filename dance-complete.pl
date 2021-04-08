#!/usr/bin/perl

=cut

=pod (tpupod) ============================================================================

=head1 NAME

   dance.pl

=head1 DESCRIPTION

Mallikoodia REST-palvelun toteuttamiseksi eri Dancer-modulilla.

POST-kutsuja:

  curl -X POST -H "Content-Type: application/json"  \\
    -d '{"username":"make","password":"xyz"}' \\
    http://localhost:3000/post/demo1

GET-kutsuja:

   curl -X GET http://localhost:3000/ip
   curl -X GET http://localhost:3000/users
  
   curl -X GET http://localhost:3000/
   curl -X GET http://localhost:3000/hello/KukaOletkaan

=cut ======================================================================================

use strict;

use Dancer;
use Data::Dumper;

#---------------------------------------------------

start_demo_dance();
exit;

#---------------------------------------------------

sub start_demo_dance {
	# set serializer => 'XML';
	#set serializer => 'JSON'; 
	 
	get '/' => \&root_get_demo_service; 
	
	get '/ip' => \&ip_get_demo_service;
	
	get '/hello/:name' => \&hello_get_demo_service;
	get '/users' => \&demo_users_get_service;

	post '/post/demo1' => \&demo1_post_service;

	get '/tips/:tipnr' => sub {
    		return "Tips number requested: " . param('tipnr');
	};
	
	dance;
}


#-------------------------------------------------------------------------------------

sub root_get_demo_service {
	my $help_text = q(
		----------------------------------------------------
		Try me.
		Get services: /ip, /hello/<name>, /users
		Post services: /post/demo1
		-----------------------------------------------------
		
	);
	
	return $help_text;
}

sub ip_get_demo_service {
	my $ip = request->remote_address;	
	return "Your IP Address is $ip";
	#return {message => "First rest Web Service with Perl and Dancer ... $ip"};
}

sub hello_get_demo_service {
	my $user = params->{name};
	return {message => "Hello $user"};
}

sub demo_users_get_service {
	my %users = (
        userA => {
            id   => "1",
            name => "Carlos",
        },
        userB => {
            id   => "2",
            name => "Andres",
        },
        userC => {
            id   => "3",
            name => "Bryan",
        },
    );

    return \%users;
	
}


sub demo1_post_service {
	# my $user = $schema->resultset('Users')->find( params->{id} );
	set serializer => 'JSON';
	# content_type 'application/json';

	my %options;

	my %params_hash = Dancer::params();
	#my %params_hash = params();
	#my %params_hash = params('query');
	my %rhash;

	if (exists  $params_hash{username} ) {
		$rhash{data}->{uid} = $params_hash{username}; 
		$rhash{data_list}[0]->{uid} = $params_hash{username}; 
		$rhash{data_list}[0]->{cn} = 'cn1';
		$rhash{data_list}[1]->{uid} = "toka";
		$rhash{data_list}[1]->{cn} = 'cn2';
		$rhash{result} = 'jes';
		return to_json \%rhash;
	}
	
	return \%params_hash;
}

