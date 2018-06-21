truncate table recipes;

insert into recipes(
	title,
    accountId,
    createdAt,
    description,
    ingredients,
    calories,
    public,
    directions
) 
values(
	'Kuchen',
    1,
    CURRENT_TIMESTAMP(),
    'This cake won me First Prize at the county fair last year. It is very chocolaty.',
    '1 package devil\'s food cake mix;1 package instant chocolate pudding mix;1 cup sour cream;1 cup vegetable oil;4 eggs;1/2 cup warm water;2 cups semisweet chocolate chips',
    2000,
    true,
    'Preheat oven to 350 degress F (175 degrees C).;
    In a large bowl, mix together the cake and pudding mixes, sour cream, oil, beaten eggs and water. Stir in the chocolate chips and pour batter into a well greased 12 cup bundt pan.;
    Bake for 50 to 55 minutes, or until top is springey to the touch and a wooden toothpick inserted comes out clean.
	Cool cake thoroughly in pan at least an hour anda a half before inverting onto a plate if desired, dust the cake with powdered sugar.'
);