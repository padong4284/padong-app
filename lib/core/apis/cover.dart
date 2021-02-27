import 'package:padong/core/models/pip.dart';

Map<String, dynamic> getCoverAPI(String coverId) {
  return {
    'id': 'cover009',
    'parentId': 'univ009',
    'emblem':
        'https://1000logos.net/wp-content/uploads/2019/06/Georgia-Tech-Logo.png',
    'loc': 'North Ave NW,\nAtlanta, GA 30332',
    'fixedWikis': {
      'Vision': 'w009000',
      'Mission': 'w009001',
      'History': 'w009002',
    },
    'wikis': [
      // List of wikiId
      'w009023', 'w009346', 'w0092374', 'w009124', 'w009024',
    ],
  };
}

Map<String, dynamic> getWikiAPI(String wikiId) {
  int k = int.parse(wikiId[wikiId.length-1]);
  return {
    'id': wikiId,
    'parentId': 'cover009',
    'pip': PIP.PUBLIC,
    'bottoms': [0, 0, 0], // likes, replies, bookmarks counting list
    'isLiked': false,
    'isBookmarked': false,
    'createdAt': DateTime(2021, 2, 27, 14, 13),
    'title': k > 2 ? 'Title' : ['Vision', 'Mission', 'History'][k],
    'description': """Helping students learn How Work Works.
## OUR MISSION
To provide career education, resources, 
and experiential opportunities to Georgia 
Tech students across all majors so that they 
are positioned to launch and sustain 
satisfying and successful careers that make 
a meaningful contribution to society.

In collaboration with campus and global 
community partners, we aim to support a 
broad spectrum of career directions, 
including: employment in private, public, 
and non-profit sectors; pursuit of graduate 
studies, professional school, and prestigious 
fellowships; entrepreneurship and 
innovation; research; and service activities.

## OUR VISION

Georgia Tech students who participate in the 
career center’s educational and experiential 
offerings will not only graduate with a 
promising future; they will be equipped with 
the career management skills and 
knowledge necessary for navigating that 
future and making a difference in the world 
through innovative, purposeful leadership."""
  };
}


List<String> get10RecentWikiIdsAPI(String coverId) {
  /* TODO
  1. Get Board Node
  2. get 10 recent postIds from Board's children
  3. return List<postIds>
  */
  return Iterable<int>.generate(10).map((i) => 'w' + coverId + i.toString()).toList();
}
