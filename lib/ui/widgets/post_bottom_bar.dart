import 'package:flutter/material.dart';

class PostBottomBar extends StatelessWidget {
  const PostBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: const BoxDecoration(
          color: Color(0xFFEDF2F6),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          )),
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "City Name, Country",
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 25,
                      ),
                      Text(
                        "4.5",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                style: TextStyle(color: Colors.black54, fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Expanded(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "images/city5.jpg",
                        fit: BoxFit.cover,
                        width: 120,
                        height: 90,
                      ),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Expanded(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        "images/city4.jpg",
                        fit: BoxFit.cover,
                        width: 120,
                        height: 90,
                      ),
                    )),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 90,
                      margin: const EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(image: AssetImage("images/city6.jpg"),
                        fit: BoxFit.cover,
                        opacity: 0.4)
                      ),
                      child: const Text(
                        "10+",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    )
                  )
                ],
              ),
              SizedBox(height: 15,),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueAccent,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4
                          ),
                        ],
                      ),
                      child: Text(
                        "Book Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
