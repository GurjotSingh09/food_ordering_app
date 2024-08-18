class Content {
  String image;
  String title;
  String description;

  Content(
      {required this.description, required this.image, required this.title});
}

List<Content> contents = [
  Content(
      description: 'Pick your food from our menu \n        More than 35 times.',
      image: 'assets/images/screen1.png',
      title: 'Select from our\n    Best Menu.'),
  Content(
      description:
          'You can pay Cash on Delievery \n and Card payment is available.',
      image: 'assets/images/screen2.png',
      title: 'Easy and online payment '),
  Content(
      description: 'Deliver your food at \n     your Doorstep.',
      image: 'assets/images/screen3.png',
      title: 'Quick Delievery at your Door.'),
];
