class MappingIDs {
  final Map<String, String> cities = {
    'Baghdad': '1',
    'Erbil': '2',
    'Basra': '3',
  };

  final Map<String, String> categories = {
    'Residential': '8E71I7',
    'Building Complex': 'C8D46D',
    'Commercial': '103',
    'Industrial': '103',
    'Agriculture': '103',
  };

  final Map<String, Map<String, String>> subcategories = {
    'Residential': {
      'Land': '8E71I7',
      'Flat': 'HJEFGC',
      'Villa': '2EF6D4',
      'Building': '4IF2ID',
    },
    'Building Complex': {
      'Land': '8E71I7',
      'Flat': 'HJEFGC',
      'Villa': '2EF6D4',
      'Building': '4IF2ID',
    },
    'Industrial': {
      'Factory': '205',
      'Warehouse': '206',
    },
  };
}
