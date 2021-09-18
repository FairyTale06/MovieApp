import 'package:flutter/material.dart';
import 'package:movie_app/services/movie_service.dart';

class Popular extends StatefulWidget {

  @override
  _PopularState createState() => _PopularState();
}

int called = 0;
int totalPages;
int currentPage = 1;

Future<List> getPopular() async {
  MovieService instance = MovieService();

  // if(called == 0){
    var result = await instance.getPopular(currentPage.toString());
    totalPages = result['lastPage'];
    currentPage = result['currentPage'];
    print(currentPage);
    called += 1;
    return result['result'];
  // }else{
  //   called = 0;
  // }
}

class _PopularState extends State<Popular> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: FutureBuilder <List>(
          future: getPopular(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              List data = snapshot.data;
              return Column(
                children: [
                  Text(
                    "Popular Movie",
                    style: TextStyle(
                        fontSize: 26,
                        color: Colors.white
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 16,
                      itemBuilder: (BuildContext context, int index){
                        return Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Card(
                            // color: Color(0xff5345cc),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[
                                        Colors.deepPurple,
                                        Colors.deepPurpleAccent,
                                        Colors.blueAccent
                                      ]
                                  )
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: InkWell(
                                    onTap: () async{
                                      Navigator.pushNamed(context, "/detail", arguments: {"movieID": data[index]["id"]});
                                    },
                                    child: ListTile(
                                      leading: Image.network('https://image.tmdb.org/t/p/w200/${data[index]['poster_path']}', height: 100),
                                      title: Text(
                                        data[index]['original_title'],
                                        style: TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                      subtitle: Text(
                                        "Popularity: "+(data[index]['popularity']).toString(),
                                        style: TextStyle(
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ),
                        );
                      }
                  ),
                  Row(
                    children: [
                      if(currentPage > 1)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 16.0),
                          child: TextButton(
                              onPressed: (){
                                setState(() {
                                  currentPage -= 1;
                                  getPopular();
                                });
                              },
                              child: Text('Prev')
                          ),
                        ),
                      if(currentPage < totalPages)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 16.0),
                          child: TextButton(
                              onPressed: (){
                                setState(() {
                                  currentPage += 1;
                                  getPopular();
                                });
                              },
                              child: Text('Next')
                          ),
                        ),
                    ],
                  )
                ],
              );
            }
            return CircularProgressIndicator();
          },
        )
    );
  }
}
