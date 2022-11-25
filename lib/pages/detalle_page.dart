import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';

class DetallePage extends StatelessWidget {
  const DetallePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

    dynamic numero = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      key: _key,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Container(
          height: 140,
          width: 120,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Logo.png'),
                  fit: BoxFit.cover)),
        ),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Hero(
            tag: numero--,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/images/loading2.gif'),
                    image: NetworkImage(
                        'https://source.unsplash.com/random?sig=${numero}'),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              try {
                // Saved with this method.
                var imageId = await ImageDownloader.downloadImage(
                  'https://source.unsplash.com/random?sig=${numero}',
                );

                final snacbar = SnackBar(content: Text('Descarga Realizada 🟠'),);
                ScaffoldMessenger.of(context).showSnackBar(snacbar);

                if (imageId == null) {
                  return;
                }
              } on PlatformException catch (error) {
                print(error);
              }
            },
            icon: Icon(
              Icons.cloud_download_sharp,
              color: Colors.orange[800],
              size: 50,
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
