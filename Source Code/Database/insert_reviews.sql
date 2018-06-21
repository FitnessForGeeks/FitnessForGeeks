truncate table reviews;

select 
	insertReview(2, 1, 'Very tasty', 3.5),
	insertReview(	
		2,
		1,
		'My favorite pastitsio recipe. Others\' bechamel layers are too thick and starchy-tasting. This is so good. ',
		5
	);
