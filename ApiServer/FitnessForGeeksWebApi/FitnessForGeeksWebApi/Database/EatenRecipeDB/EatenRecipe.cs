using System;
using FitnessForGeeksWebApi.Database;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace FitnessForGeeksWebApi.Database.EatenRecipeDB
{
    public class EatenRecipe : IDatabaseObject
    {
		public EatenRecipe(int? id, int? accountId, int? recipeId, int? calories, double? avgRating, int? reviewCount, string title, string image, DateTime? date)
		{
			Id = id;
			AccountId = accountId;
			RecipeId = recipeId;
			Calories = calories;
			AvgRating = avgRating;
			ReviewCount = reviewCount;
			Title = title;
			Image = image;
			Date = date;
		}

		public int? Id { get; }
        public int? AccountId { get; }
        public int? RecipeId { get; }
		public int? Calories { get; }
		public int? ReviewCount { get; }
		public double? AvgRating { get; }
		public string Title { get; }
		public string Image { get; }
        public DateTime? Date { get; }
    }
}
