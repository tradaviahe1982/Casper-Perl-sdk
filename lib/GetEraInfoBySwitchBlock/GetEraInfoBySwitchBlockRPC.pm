# Class built for chain_get_era_info_by_switch_block RPC call
package GetEraInfoBySwitchBlock::GetEraInfoBySwitchBlockRPC;
use LWP::UserAgent;
use Data::Dumper;
use Common::ErrorException;
use JSON qw( decode_json );
sub new {
	my $class = shift;
	my $self = {_url=>shift};
	bless $self, $class;
	return $self;
}
# get-set method for _url
sub setUrl {
	my ($self,$value) = @_;
	$self->{_url} = $value if defined ($value);
	return $self->{_url};
}
sub getUrl {
	my ($self) = @_;
	return $self->{_url};
}
=comment
	 * This function initiate the process of sending POST request with given parameter in JSON string format
     * The input parameterStr is used to send to server as parameter of the POST request to get the result back.
     * The input parameterStr is somehow like this:
     * {"params" :  [], "id" :  1, "method": "chain_get_block", "jsonrpc" :  "2.0"}
     * if you wish to send without any param along with the RPC call
     * or:
     * {"method" :  "chain_get_era_info_by_switch_block", "id" :  1, "params" :  {"block_identifier" :  {"Hash" : "d16cb633eea197fec519aee2cfe050fe9a3b7e390642ccae8366455cc91c822e"}}, "jsonrpc" :  "2.0"}
     * if you wish to send the block hash along with the POST method in the RPC call
     * or:
     * {"method" :  "chain_get_era_info_by_switch_block", "id" :  1, "params" :  {"block_identifier" :  {"Height" : 100}}, "jsonrpc" :  "2.0"}
     * if you wish to send the block height along with the POST method in the RPC call
     * The parameterStr is generated by the BlockIdentifier class, declared in file Common::BlockIdentifier.pm
     * Then the GetBlockResult is retrieved by parsing JsonObject result
     * If the result is error,  then an exception is thrown
     * Else the GetEraInfoResult is taken by parsing the  retrieving JsonObject
=cut
sub getEraInfo {
	my ($self) = @_;
	my @list = @_;
	my $uri = $self->{_url};
	if($uri) {
	} else {
		$uri = $Common::ConstValues::TEST_NET;
	}
	my $json = $list[1];
	my $req = HTTP::Request->new( 'POST', $uri );
	$req->header( 'Content-Type' => 'application/json');
	$req->content( $json );
	my $lwp = LWP::UserAgent->new;
	my $response = $lwp->request( $req );
	if ($response->is_success) {
	    my $d = $response->decoded_content;
	    my $decoded = decode_json($d);
	    my $errorCode = $decoded->{'error'}{'code'};
	    if($errorCode) {
	    	my $errorException = new Common::ErrorException();
	    	$errorException->setErrorCode($errorCode);
	    	$errorException->setErrorMessage($decoded->{'error'}{'message'});
	    	return $errorException;
	    } else {
		    my $ret = GetEraInfoBySwitchBlock::GetEraInfoResult->fromJsonToGetEraInfoResult($decoded->{'result'});
		   	return $ret;
	    }
	}
	else {
	    die $response->status_line;
	}
}
1;