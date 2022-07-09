import 'package:cs_major_review/models/discussion_model.dart';
import 'package:cs_major_review/models/forum_model.dart';

final allForums = <Forum>[
  Forum(
      topic: "Let's talk about Algo",
      user: "Jaehyun",
      createdBy: "Sun Jul 3 2022",
      comment:
          "We have good lecturers here, so it is fun and very useful, recommneded!",
      num: 14,
      discussions: [
        Discussion(
            comment:
                "I really love this class, but it required a lot of disclipline, worth the reading and studying",
            user: "User 1")
      ],
      tags: [
        "DSOOP",
        "ALGO"
      ]),
  Forum(
      topic: "I love Discrete Math",
      user: "Jeno",
      createdBy: "Fri Jul 2 2022",
      comment: "This class is way too fun!",
      num: 10,
      discussions: [
        Discussion(comment: "The content is good!", user: "User 1")
      ],
      tags: [
        "DISCRETE MATH",
        "Mahidol Uni."
      ])
];
