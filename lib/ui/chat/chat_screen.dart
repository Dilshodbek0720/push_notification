// import 'package:chat_app/ui/widgets/global_text_fields.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../data/chat_model.dart';
// import '../data/providers/chat_provider.dart';
//
// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0E1621),
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: const Color(0xFF17212B),
//         title: const Text("Chat Screen"),
//       ),
//       body: StreamBuilder<List<ChatModel>>(
//         stream: context.read<ChatProvider>().getProducts(),
//         builder:
//             (BuildContext context, AsyncSnapshot<List<ChatModel>> snapshot) {
//           if (snapshot.hasData) {
//             return snapshot.data!.isNotEmpty
//                 ? Column(
//                   children: [
//                     Expanded(
//                       child: ListView(
//               children: List.generate(
//                       snapshot.data!.length,
//                           (index) {
//                             ChatModel chatModel = snapshot.data![index];
//                         return Row(
//                           mainAxisAlignment: chatModel.name=="Dilshodbek" ? MainAxisAlignment.end:MainAxisAlignment.start,
//                           children: [
//                             Container(
//                               margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
//                               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(6),
//                                   color: Colors.deepPurple
//                                 ),
//                                 child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(chatModel.name, style: const TextStyle(
//                                 color: Colors.redAccent
//                                 ),),
//                                 const SizedBox(height: 5,),
//                                 Text(chatModel.massage, style: const TextStyle(
//                                   color: Colors.white
//                                 ),),
//                               ],
//                             ))
//                           ],
//                         );
//                       },
//               ),
//             ),
//                     ),
//                     GlobalTextField(hintText: "Write a message..", keyboardType: TextInputType.text, textInputAction: TextInputAction.done, textAlign: TextAlign.start, controller: context.read<ChatProvider>().massage,onPressed: () {
//                       context.read<ChatProvider>().addProduct(
//                           context: context,
//                           chatModel: ChatModel(
//                               name: "Anynomous",
//                               massage: context.read<ChatProvider>().massage.text,
//                               productId: "",
//                               createdAt: DateTime.now().toString()));
//                     },)
//                   ],
//                 )
//                 : Column(
//                   children: [
//                     const Expanded(child: Center(child: Text("Chat Empty!", style: TextStyle(
//                       fontSize: 25,
//                       color: Colors.white60
//                     ),))),
//                     GlobalTextField(hintText: "Write a message..", keyboardType: TextInputType.text, textInputAction: TextInputAction.done, textAlign: TextAlign.start, controller: context.read<ChatProvider>().massage,onPressed: () {
//                       context.read<ChatProvider>().addProduct(
//                           context: context,
//                           chatModel: ChatModel(
//                               name: "User1",
//                               massage: context.read<ChatProvider>().massage.text,
//                               productId: "",
//                               createdAt: DateTime.now().toString()));
//                     },)
//                   ],
//                 );
//           }
//           if (snapshot.hasError) {
//             return Center(
//               child: Text(snapshot.error.toString()),
//             );
//           }
//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }