
class FAQModel{
  bool? status;
  FaqData? data;
  FAQModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=json['data']!=null? FaqData.fromJson(json['data']):null;
  }
}

class FaqData{
  int? currentPage;
  List<Question> question=[];
  FaqData.fromJson(Map<String,dynamic>json){
    currentPage=json['current_page'];
    json['data'].forEach((e){
      question.add(Question.fromJson(e));
    });
  }
}

class Question{
  int? id;
  String? question;
  String? answer;

  Question.fromJson(Map<String,dynamic>json){
    id=json['id'];
    question=json['question'];
    answer=json['answer'];
  }
}