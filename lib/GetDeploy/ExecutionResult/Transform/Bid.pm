# Class built for storing Bid information

package GetDeploy::ExecutionResult::Transform::Bid;

sub new {
	my $class = shift;
	my $self = {
		_bondingPurse => shift,
		_delegationRate => shift,
		_inactive => shift,
		_delegators => [ @_ ], # list of Delegator
		_stakedAmount => shift, # of type U512
		_validatorPublicKey => shift,
		_vestingSchedule => shift, # Optional value of type VestingSchedule
	};
	bless $self, $class;
	return $self;
}

# get-set method for _bondingPurse
sub setBondingPurse {
	my ($self,$bondingPurse) = @_;
	$self->{_bondingPurse} = $bondingPurse if defined($bondingPurse);
	return $self->{_bondingPurse};
}
sub getBondingPurse {
	my ($self)  = @_;
	return $self->{_bondingPurse};
}

# get-set method for _delegationRate
sub setDelegationRate {
	my ($self,$delegationRate) = @_;
	$self->{_delegationRate} = $delegationRate if defined($delegationRate);
	return $self->{_delegationRate};
}
sub getDelegationRate {
	my ($self)  = @_;
	return $self->{_delegationRate};
}

# get-set method for _inactive
sub setInactive {
	my ($self,$delegationRate) = @_;
	$self->{_inactive} = $delegationRate if defined($delegationRate);
	return $self->{_inactive};
}
sub getInactive {
	my ($self)  = @_;
	return $self->{_inactive};
}

# get-set method for _delegators - list
sub setDelegators {
	my ( $self, @delegators) = @_;
	$self->{_delegators} = \@delegators;
	return $self->{_delegators};
}

sub getDelegators {
	my ( $self ) = @_;
	my @delegators = @{ $self->{_delegators} };
	wantarray ? @delegators :\@delegators;
}

# get-set method for _stakedAmount
sub setStakedAmount {
	my ($self,$stakedAmount) = @_;
	$self->{_stakedAmount} = $stakedAmount if defined($stakedAmount);
	return $self->{_stakedAmount};
}
sub getStakedAmount {
	my ($self)  = @_;
	return $self->{_stakedAmount};
}

# get-set method for _validatorPublicKey
sub setValidatorPublicKey {
	my ($self,$validatorPublicKey) = @_;
	$self->{_validatorPublicKey} = $validatorPublicKey if defined($validatorPublicKey);
	return $self->{_validatorPublicKey};
}
sub getValidatorPublicKey {
	my ($self)  = @_;
	return $self->{_validatorPublicKey};
}

# get-set method for _vestingSchedule
sub setVestingSchedule {
	my ($self,$vestingSchedule) = @_;
	$self->{_vestingSchedule} = $vestingSchedule if defined($vestingSchedule);
	return $self->{_vestingSchedule};
}
sub getVestingSchedule {
	my ($self)  = @_;
	return $self->{_vestingSchedule};
}

# This function parse the JsonObject (taken from server RPC method call) to get the Bid object
sub fromJsonToBid {
	
}