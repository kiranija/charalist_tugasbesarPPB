import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail.dart';
import 'profile.dart';
import 'air.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Show>> shows;
  late Future<List<Shows>> showair;
  @override
  void initState() {
    super.initState();
    shows = fetchShows();
    showair = fetchShow();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('CHARA LIST'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(7),
            child: const Text(
              'THE BEST ANIME CURRENTLY AIRING',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder(
            builder: (context, AsyncSnapshot<List<Shows>> snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 230,
                  child: ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) => Card(
                      color: Color.fromARGB(255, 73, 96, 230),
                      child: InkWell(
                        child: Container(
                          height: 200,
                          width: 150,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Image.network(
                                    snapshot
                                        .data![index].airimage.jpg.image_url,
                                    height: 200,
                                    width: 150,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    height: 170,
                                    width: 150,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Opacity(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: Container(
                                                  padding: EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[800]),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.star,
                                                        size: 20,
                                                        color: Colors.yellow,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Center(
                                                        child: Text(
                                                          snapshot.data![index]
                                                              .airscore
                                                              .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              opacity: 0.7,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                snapshot.data![index].airtitle,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailAirPage(
                                        item: snapshot.data![index].airmalId,
                                        title: snapshot.data![index].airtitle,
                                      )));
                        },
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong :('));
              }
              return const CircularProgressIndicator();
            },
            future: showair,
          ),
          Container(
            padding: EdgeInsets.all(7),
            child: const Text(
              'BEST ANIME',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              builder: (context, AsyncSnapshot<List<Show>> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.teal,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  snapshot.data![index].images.jpg.image_url),
                            ),
                            title: Text(snapshot.data![index].title),
                            subtitle:
                                Text('Score: ${snapshot.data![index].score}'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                      item: snapshot.data![index].malId,
                                      title: snapshot.data![index].title),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                }
                return const CircularProgressIndicator();
              },
              future: shows,
            ),
          ),
        ],
      ),
    );
  }
}

class Show {
  final int malId;
  final String title;
  Images images;
  final double score;
  //final String imageUrl;
  Show({
    required this.malId,
    required this.title,
    required this.images,
    required this.score,
    //required this.imageUrl,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      malId: json['mal_id'],
      title: json['title'],
      images: Images.fromJson(json['images']),
      score: json['score'],
      //imageUrl: json['image_url'])
    );
  }

  Map<String, dynamic> toJson() => {
        'mal_id': malId,
        'title': title,
        'images': images,
        'score': score,
      };
}

class Images {
  final Jpg jpg;

  Images({required this.jpg});
  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      jpg: Jpg.fromJson(json['jpg']),
    );
  }

  Map<String, dynamic> toJson() => {
        'jpg': jpg.toJson(),
      };
}

class Jpg {
  String image_url;
  String small_image_url;
  String large_image_url;

  Jpg({
    required this.image_url,
    required this.small_image_url,
    required this.large_image_url,
  });

  factory Jpg.fromJson(Map<String, dynamic> json) {
    return Jpg(
      image_url: json['image_url'],
      small_image_url: json['small_image_url'],
      large_image_url: json['large_image_url'],
    );
  }
  //to json
  Map<String, dynamic> toJson() => {
        'image_url': image_url,
        'small_image_url': small_image_url,
        'large_image_url': large_image_url,
      };
}

Future<List<Show>> fetchShows() async {
  final response =
      await http.get(Uri.parse('https://api.jikan.moe/v4/top/anime'));

  if (response.statusCode == 200) {
    var jsonResponse = json.decode(response.body)['data'] as List;
    return jsonResponse.map((show) => Show.fromJson(show)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}

class Shows {
  final int airmalId;
  final String airtitle;
  Images airimage;
  final num airscore;
  Shows({
    required this.airmalId,
    required this.airtitle,
    required this.airimage,
    required this.airscore,
  });
  factory Shows.fromJson(Map<String, dynamic> json) {
    return Shows(
      airmalId: json['mal_id'],
      airtitle: json['title'],
      airimage: Images.fromJson(json['images']),
      airscore: json['score'],
    );
  }
}

Future<List<Shows>> fetchShow() async {
  final response = await http
      .get(Uri.parse('https://api.jikan.moe/v4/top/anime?filter=airing'));
  if (response.statusCode == 200) {
    var topShowsJson = jsonDecode(response.body)['data'] as List;
    return topShowsJson.map((showair) => Shows.fromJson(showair)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}
