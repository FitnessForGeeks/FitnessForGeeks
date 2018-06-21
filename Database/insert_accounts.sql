truncate table accounts;

insert into accounts(
	username,
    password,
    firstName,
    lastName,
    isMale,
    email,
    birthDate,
    weight,
    height,
    isVerified,
    authKey,
    description,
    createdAt
) 
values (
	'baaka',
    '30c952fab122c3f9759f02a6d95c3758b246b4fee239957b2d4fee46e26170c4', -- = pw
    'Tim',
    'Untersberger',
    true,
    'timuntersberger2@gmail.com',
    str_to_date('15.04.2001', '%d.%m.%Y'),
    92,
    182,
    true,
    'testKey',
    'Hello my name is Tim Untersberger and I love to cook and create my own little recipes. :)',
    current_timestamp()
);

insert into accounts(
	username,
    password,
    firstName,
    lastName,
    isMale,
    email,
    birthDate,
    weight,
    height,
    isVerified,
    authKey,
    description,
    createdAt
)
values (
	'trimpler',
    '30c952fab122c3f9759f02a6d95c3758b246b4fee239957b2d4fee46e26170c4', -- = pw
    'Stefan',
    'Waldl',
    true,
    'stefan.waldl@gmail.com',
    str_to_date('26.03.2000', '%d.%m.%Y'),
    80,
    186,
    false,
    'testKey2',
    'Hello my name Stefan Waldl and I love rugby.',
    current_timestamp()
);


