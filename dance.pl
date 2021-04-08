#!/usr/bin/perl

=cut

=pod (tpupod) ============================================================================

=head1 NAME

   dance.pl

=head1 DESCRIPTION

Mallikoodia REST-palvelun toteuttamiseksi eri Dancer-modulilla.

   curl -X GET http://localhost:3000/ip
   curl -X GET http://localhost:3000/tips/1

=cut ======================================================================================

use strict;

use Dancer;
use Data::Dumper;

#---------------------------------------------------

start_demo_dance();
exit;

#---------------------------------------------------

sub start_demo_dance {
	get '/' => \&root_get_demo_service; 
	get '/ip' => \&ip_get_demo_service;
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
