import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/library_model.dart';
import '../styles.dart';
import '../util/crud_model.dart';
import 'movie_library_form.dart';
import 'movie_library_home.dart';

class LibraryList extends StatelessWidget {
  const LibraryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stream<List<Library>> libraries =
        Provider.of<CrudModel>(context, listen: false).getListOfLibraries;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        toolbarHeight: 10,
      ),
      body: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
            ),
            child: Container(
              child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "All Libraries",
                      style: Styles.textSectionHeader,
                    ),
                    Text(
                      "Custom Libraries to Manage Favorite Movies",
                      style: Styles.textSectionSubBody,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      flex: 9,
                      child: SafeArea(
                        child: StreamBuilder<List<Library>>(
                          stream: libraries,
                          builder: (context, snapshot) {
                            if(snapshot.hasError){
                              return Text("Error");
                            } else if(snapshot.hasData){
                              final libraries = snapshot.data!;
                              return ListView(
                                  children: libraries.map((e) => buildLibrary(e, context)).toList(),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator(),);
                            }
                          }
                        ),
                      ),
                    ),
                  ],
                ),
            ),
          )
    );
  }
  Widget buildLibrary(Library library, BuildContext context) => GestureDetector(
    onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>   LibraryHome(libraryId: library.id.toString(), libraryName: library.name,)),
      );
    },
    child: Card(
      elevation: 6,
      child: ListTile(
        leading: const CircleAvatar(child: Text("O")),
        title: Text(library.name),
        trailing: Wrap(
          spacing: 12,
          children: [
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  LibraryForm(libraryId: library.id, functionValue: 1, libraryName: library.name,)),
                );
              },
              child: Icon(Icons.edit, color: Colors.black,),
            ),
            InkWell(
              onTap: (){
                print("Library Delete - PROTO");
              },
              child: Icon(Icons.delete, color: Colors.redAccent,),
            ),
          ],
        )
      ),
    ),
  );

}
