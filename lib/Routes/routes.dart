

/*class FluroRouter {
  static Router router = Router();
  static Handler _storyhandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          HomeView(id: params['id'][0]));
  static Handler _homehandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          Home());
  static void setupRouter() {
    router.define(
      '/',
      handler: _homehandler,
    );
    router.define(
      '/story/:id',
      handler: _storyhandler,
    );
  }
}*/