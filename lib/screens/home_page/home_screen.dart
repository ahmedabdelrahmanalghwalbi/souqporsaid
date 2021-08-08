import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:souqporsaid/alertToast.dart';
import 'package:souqporsaid/screens/home_page/productTestModel.dart';
import 'package:souqporsaid/screens/home_page/topHeaderSlider/productItem.dart';
import 'package:souqporsaid/screens/home_page/topHeaderSlider/productList.dart';
import 'package:souqporsaid/screens/home_page/topHeaderSlider/staggredDualView.dart';
import 'package:souqporsaid/screens/search/search_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../responsize.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String collectionName = "MostSellingProducts";
  List panels = [
    [
        ' لقد تلقيت منتجا معيباً / تالفاً ،هل يمكنني استرداد قيمته مجدداً؟',
        'في حالة تلف المنتج الذي تلقيته أو إذا شابه عيب، يمكنك إرجاع المنتج خلال 30 يوم من تاريخ استلامه وذلك بشرط ان يكون في نفس الحالة التي تلقيته عليها مع الصندوق الأصلي سليم و/ أو العبوه سليمه، بمجرد استلامنا للمنتج المترجع، سنقوم بفحصه، وإذا وجد أن المنتج معيب أو تالف، فسنقوم بإعادة قيمة المنتج المدفوعة مع أي رسوم شحن تم دفعها وذلك خلال اسبوع واحد من تاريخ طلبك لإرجاع المنتج',
        false],
    [
        'لقد تلقيت منتجاً خاطئ ، كيف يمكنني إعادته؟',
        'في الظروف غير العادية التي يكون فيها المنتج المستلم خاطئاَ ، يمكنك إرجاع المنتج في نفس الحالة التي تلقيته عليها مع الصندوق الأصلي سليم و/ أو العبوه سليمه. بمجرد استلامنا للمنتج المرتجع، سنقوم بإعادة المبلغ المدفوع طالما قد تم الأسترجاع خلال 14 يوماً',
        false],

    [
        ' لقد غيرت رأيي؛ هل يمكنني إرجاع ما اشتريته؟',
        'إذا غيرت رأيك قبل استلام المنتج الخاص بك، فما عليك سوى الإتصال بنا لإلغاء طلبك وسنقوم بإعادة المبلغ المدفوع مع أي رسوم شحن مطبقه، أما إذا كنت ترغب في إرجاع المنتج بعد استلامه ، فلديك ما يصل إلى 14 يوماً لإعادته ، مع مراعاة القواعد المذكوره أدناه:ألا يكون المنتج في قائمة "المنتجات الغير قابلة للإرجاع".ألا يكون المنتج من سلع التصفيه و المذكور عليها بوضوح أنه غير قابل للإرجاع.فقط المنتجات التى لم يتم فتح "غلاف سلع التجزئة" الخاص بها أبداً (صندوق مغلق / مبرشم) ولازال عليها ختمها الاصلي يمكن إرجاعها',
        false],
    [
        'المنتجات التي لا يمكن إرجاعها هي',
        'عندما تنص ملاحظات العرض على وجه التحديد أن المنتج لا يمكن إرجاعه.المنتجات التي تندرج تحت الأنواع المذكوره أدناه:الثياب الداخليةالملابس الداخلية الجوارب البرمجيات ألبومات الموسيقى الكتب ملابس السباحة مستحضرات التجميل والعطور الجوارب النسائية أيضا، أي منتجات قابله للإستهلاك تم إستخدامها أو تركيبها لا يمكن إرجاعها. كما هو موضح في قانون حماية المستهلك ولائحته التنفيذية وفي قسم المنتجات غير القابلة للإرجاع',
        false],
    [
        'كم يستغرق من الوقت لأستلام المنتجات المرتجعه؟',
        'عادة، سوف يتصل بك أحد ممثلي شركة الشحن في غضون 3-5 أيام  عمل من اليوم الذي طلبت فيه الإرجاع',
        false],
    [
      '•	عن سوق بورسعيد',
      '•	هو موقع للتجارة الإلكترونية  ، ويضم الكثير من المنتجات من مختلف الفئات التي تشمل الإلكترونيات، والأزياء، والمنتجات المنزلية، والساعات، والعطور، وغيرها..سوق بورسعيد يعمل كموقع للبيع بالتجزئة بالإضافة إلى عمله كسوق للبائعين من جهات خارجية. ويقدم سوق بورسعيد تجربة تسوق مريحة وآمنة ، مع إمكانية الدفع نقداً عند استلام السلع، وإمكانية إرجاعها',
      false],
    [
      'سياسه الخصوصيه ',
      'تعنى (سياسة الخصوصية) لدينا بطريقة جمعنا وحفظنا واستخدامنا وطريقة حماية معلوماتك الشخصية ومن المهم ان تقوم بالإطلاع سياسة الخصوصية هذه. ونقصد بالمعلومات الشخصية هي المعلومات التي ترتبط بشخص معين والتي تستخدم في التعريف عنه. نحن لا نأخذ بعين الاعتبار أي معلومات مجهولة المصدر لانها لا تصلح في تشكيل معلومات شخصية ولكننا نقوم بجمع المعلومات الشخصية او صفحات الانترنت المرتبطة (بما في ذلك وعلى سبيل الحصر بيعك وشرائك لبضائع او حين تتصل هاتفيا او بواسطة البريد الالكتروني بفريق مركز دعم المستخدمين لدينا). وبمجرد تزويدك لنا بمعلوماتك الشخصية تكون قد فوضتنا لمعالجة هذه المعلومات وفق بنود وشروط (سياسة الخصوصية) . قد نقوم بتعديل (سياسة الخصوصية) في اي وقت وذلك من خلال الإعلان عن هذا التعديل بنشر النسخة المعدلة على الموقع. وتكون النسخة المعدلة من (سياسة الخصوصية) سارية المفعول اعتبارا من تاريخ نشرها. في اعقاب النشر يعتبر استمرارك في استخدام الموقع موافقة منك بالشروط والبنود الواردة في النسخة المعدلة لطريقة معالجتنا وتعاملنا مع معلوماتك الشخصية التي كنت قد زودتنا بها. نأمل منكم الإطلاع على الموقع من حين لأخر للإعلانات عن اية تعديلات على سياسة الخصوصية قد نقوم بتعديل (سياسة الخصوصية) في اي وقت وذلك من خلال الإعلان عن هذا التعديل بنشر النسخة المعدلة على الموقع. وتكون النسخة المعدلة من (سياسة الخصوصية) سارية المفعول اعتبارا من تاريخ نشرها. في اعقاب النشر يعتبر استمرارك في استخدام الموقع موافقة منك بالشروط والبنود الواردة في النسخة المعدلة لطريقة معالجتنا وتعاملنا مع معلوماتك الشخصية التي كنت قد زودتنا بها. نأمل منكم الإطلاع على الموقع من حين لأخر للإعلانات عن اية تعديلات على سياسة الخصوصية.',
      false],
    [
      'تغطي (سياسة الخصوصية) المواضيع التالية',
      'جمعنا لمعلوماتك الشخصية ... إستخدامنا لمعلوماتك الشخصية ... استخدامك لمعلوماتك الشخصية ومعلومات المستخدمين الاخرين ... إستخدام ودخول وتصفح وتعديل معلوماتك الشخصية ... حماية معلوماتك الشخصية ... كيف يمكنك الاتصال بنا للاستفسار عن (سياسة الخصوصية)',
      false],
    [
      'جمعنا لمعلوماتك الشخصية',
      'كجزء من التسجيل على الموقع أو استخدامه سوف يطب منك تزويدنا بمعلومات شخصية محددة مثل اسمك وعنوان الشحن وبريدك الالكتروني و/أو رقم هاتفك ومعلومات اخرى مشابهة وبعض المعلومات الاضافية عنك مثل تاريخ ميلادك أو اي معلومات محددة لهويتك. إضافة إلى ذلك وبهدف توثيقنا لهويتك قد نحتاج منك أن تقدم لنا اثبات ساري المفعول يثبت هويتك (مثلا نسخة عن جواز سفرك وتاشيرة او تصريح الاقامة والهوية الوطنية و/ أو رخصة القيادة). قد نحتاج ايضا الى جمع معلومات مالية محددة منك، مثلا بطاقتك الائتمانية و/أو تفاصيل حسابك المصرفي . 3. يجب عليك ادخال هذه المعلومات المالية في قسم "حسابي" على الموقع. وسوف نستخم هذه المعلومات لغايات اصدار الفوانير واسنكمال طلباتك. عند تسجيلك في الموقع، ينبغى عليك عدم نشر اي معلومات شخصية (بما في ذلك اي معلومات مالية) على اي جزء من الموقع باستثناء جزء" إدارة الحساب" وهذا من شأنه حمايتك من امكانية تعرضك للاحتيال او سرقة معلومات هويتك. كما ان نشرك لأي من معلوماتك الشخصية على اي جزء من الموقع باستثناء"حسابي" قد يؤدي الى ايقاف استخدامك للموقع 4. سوف يتم جمع معلومات عن عملياتك وأنشطتك على الموقع سواء كانت عملية شراء أو بيع سلع. أخيرًا، قد نجمع معلومات إضافية منك أو عنك بطرق أخرى غير موصوفة هنا تحديدًا. على سبيل المثال، قد نقوم بجمع المعلومات المتعلقة بتواصلك مع فريق دعم العملاء أو من خلال اجابتك على الاستبيانات. قد نجمع أيضًا التقييمات والتعليقات الأخرى المتعلقة باستخدامك للموقع. عندما نقوم بتجميع المعلومات الشخصية للأغراض الإحصائية، يجب أن تكون أسماء أصحاب المعلومات مجهولة',
      false],
    [
      'استخدامنا لمعلوماتك الشخصية',
      'نستخدم معلوماتك الشخصية لتقديم خدمات ودعم من فريق العملاء وبهدف قياس مستوى خدماتنا وتحسينها لك ومنع النشاطات غير القانونية وتنفيذ لبنود اتفاقية الاستخدام الموفقة معك ("اتفاقية الاستخدام")، اضافة الى حل المشاكل وجمع الرسوم وتزويدك برسائل الكترونية ترويجية وكذلك من اجل توثيق المعلومات التي زودتنا بها مع اطراف ثالثة مثلا قد نلجأ الى مشاركة بعض من معلوماتك الشخصية مع البنوك او التفويض لبطاقات الائتمان لمعالجة وتوثيق خدمات أو مع اطراف ثالثة لغايات التحقق من عمليات الاحتيال. برغم حرصنا للمحافظة على سرّيتك، الا اننا قد نحتاج الى الافصاح عن معلوماتك الشخصية لاجهزة تنفيذ القانون والهيئات الحكومية او اطراف ثالثة، نكون ملزمين بفعل ذلك باوامر من المحكمة اوغيرها من الدوائر القانونية لنكون ملتزمين ببنود القانون أو عند اعتقادنا ان الافصاح عن معلوماتك الشخصية ربما يقي من أذى جسدي او خسارة مالية او للاخبار عن نشاط مشبوه او للتحقيق في امكانية انتهاك لبنود وشروط اتفاقية المستخدم واية اتفاقيات أو لحماية الحقوق أو ملكية أو سلامة سوق أومستخدمينا أو الغير. 3. المعلومات الشخصية التي قمت بتزويدنا بها عند التسجيل يجب أن تبقى محدثة دائما.سيتم عرض المعلومات المتعلقة بالمنتجات التي تقوم بشرائها أو بيعها . يمكن أن تتضمن هذه المعلومات تفاصيل حول هوية المستخدم الخاصة بك والتقييمات والتعليقات المرتبطة باستخدامك للموقع. 5. لا نبيع أو نؤجر اي من معلوماتك الشخصية لطرف ثالث ضمن نطاق عملنا التجاري المعتاد وسوف نشارك فقط معلوماتك الشخصية فقط وفق ما جاء في (سياسة الخصوصية)',
      false],
    [
      'إستخدام ودخول وتصفح وتعديل معلوماتك الشخصية',
      'باستطاعتك الوصول ومراجعة معلوماتك الشخصية من خلال صفحة إدارة "حسابي"على الموقع، فاذا تغيرت معلوماتك الشخصية باي طريقة او اعطيت معلومات غير صحيحة على الموقع فعليك القيام بتحديثها او تصحيحها حالا، اما من خلال عرضها على "حسابي" او من خلال الاتصال بفريق خدمة العملاء. يحتوي الرابط الخاص ب " دعم العملاء" والموجود في أعلى كل صفحة على البريد الإلكتروني ورقم الهاتف الخاص بهذا القسم. يرجى العلم أننا سوف نحتفظ بمعلوماتك الشخصية خلال وبعد انتهائك من استخدام الموقع بحسب ما هو مطلوب قانونا، وذلك بهدف التغلب على العوائق التقنية ,ولمنع الاحتيال، و للمساعدة في اي تحقيق قانوني ولاتخاذ اي اجراءات اخرى ينص عليها القانون. حماية معلوماتك الشخصية عند تزودنا بمعلوماتك الشخصية تكون قد وافقت على نقل هذه المعلومات الينا ، ونحن نتخذ كافة الاحتياطات للمحافظة على معلوماتك وذلك بعدم الوصول اليها او استخدامها او الافصاح عنها بشكل غير مخول. كافة المعلومات الشخصية مشفرة، وعلى اي حال فان الانترنت وسيلة غير امنة ونحن لا نضمن سرية معلوماتك الشخصية. يتم ادخال اسم المستخدام وكلمة السر القيام باية معامللات في الموقع. يجب ان يتم اختيار كلمة السر بحذر باستخدام ارقام وحروف واشكال مميزة',
      false],
    [
      'لا تشارك اسم المستخدم وكلمة السر مع اي احد',
      'في حال كان لديك شك حول اختراق اسم المستخدم وكلمة السر، يرجى على الفور الاتصال بفريق خدمة العملاء والعمل على تغيير كلمة السر وذلك بالدخول الى قسم اتصل بنا علي الموقع ',
      false],
    [
      'متى يكون "الإرجاع" غير ممكن؟',
      'هناك بعض الحالات التي يصعب علينا فيها دعم الإرجاع:إن تم طلب الإرجاع خارج الإطار الزمني المحدد وهو 14 يوماً أو 30 يوم للمنتجات المعيبة أو غير المطابقة للمواصفات من يوم الإستلام .إذا كان المنتج مستخدم، تالف أو ليس في نفس الحالة التي تلقيته عليها.الفئات المحددة الغير قابلة للإرجاع مثل الملابس الداخلية، مستحضرات التجميل والجوارب...الخ.المنتجات المعيبة التي يغطيها ضمان الشركة المصنعةأي منتج قابل للإستهلاك تم إستخدامه أو تركيبه.المنتجات التي تحمل رقم تسلسلي تم التلاعب به أو كان مزيف.أي شيء مفقود من العبوه التى استلمتها بما في ذلك علامات السعر والملصقات والتغليف الأصلى و الملحقات المجانية والاكسسوارات.المنتجات الهشة والمتعلقة بالنظافة الشخصية',
      false],
  ];
  List<String> timelines = ['الاكثر مبيعا', 'عروض خاصة', 'منتجات حصرية'];
  String selectedTimeline ='الاكثر مبيعا';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Widget topHeader=Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedTimeline = timelines[0];
                    collectionName="MostSellingProducts";
                  });
                },
                child: Text(
                  timelines[0],
                  style: TextStyle(
                      fontSize: timelines[0] == selectedTimeline ? 20 : 14,
                      color: Colors.white),
                ),
              ),
            ),
            Flexible(
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedTimeline = timelines[1];
                    collectionName="ExeclusiveProducts";
                  });
                },
                child: Text(timelines[1],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: timelines[1] == selectedTimeline ? 20 : 14,
                        color: Colors.white)),
              ),
            ),
            Flexible(
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedTimeline = timelines[2];
                    collectionName="SpecialOffersOrders";
                  });
                },
                child: Text(timelines[2],
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontSize: timelines[2] == selectedTimeline ? 20 : 14,
                        color: Colors.white)),
              ),
            ),
          ],
        ));
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset("assets/appBarLogo.png"),
        centerTitle: true,
        actions: [
          GestureDetector(
            child: Icon(Icons.search,color: Colors.white,),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchPage()));
            },),
        ],
      ),
      drawer: Drawer(
        child:SafeArea(
          bottom: true,
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:24.0,right:24.0,bottom: 16.0),
                  child: Text(
                    'المساعدة',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                ),... panels.map((panel)=>ExpansionTile(
                    title: Text(
                      panel[0],
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    ),

                    children: [Container(
                        padding: EdgeInsets.all(16.0),
                        color: Color(0xffFAF1E2),
                        child: Text(
                            panel[1],
                            style:
                            TextStyle(color: Colors.grey, fontSize: 12)))])).toList(),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  height: 2,
                  color: Colors.grey,
                  thickness: 1,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  FloatingActionButton(onPressed: ()async{
                    final link = WhatsAppUnilink(
                      phoneNumber: '+201208907983',
                      text: "أهلا .. سوق بورسعيد !",
                    );
                    await launch('$link');
                  },
                    backgroundColor: Colors.green,
                    child: Center(
                      child: Icon(Icons.phone,color: Colors.white,),
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.only(left:24.0,right:24.0,bottom: 16.0),
                      child: Text(
                        'للتواصل',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                ],),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) {
            // These are the slivers that show up in the "outer" scroll view.
            return <Widget>[
              SliverToBoxAdapter(
                child:topHeader
              ),
              SliverToBoxAdapter(
                child: Padding(
                padding:  EdgeInsets.only(top:10.0),
                child: Container(
                height:MediaQuery.of(context).size.height/2.7,
                width: MediaQuery.of(context).size.width/1.8,
                  child: ProductList(
                    collectionName: collectionName,
                  ),
                ),
                ),
              ),
            ];
          },
          body: Container(
            margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
              color: Color(0xffF8F8F9)
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //new product and see all row
                  Padding(
                    padding: EdgeInsets.only(top: 10,right: 15,left: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                              Text("المنتحات الجديدة",style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2
                              ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //horizontal List of new Products
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/3,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("Product").limit(10).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                        if (snapshot.hasError) {
                          return  Text('يوجد خطأ في تحميل الفئات',textAlign: TextAlign.center,style: TextStyle(
                              color: Colors.orange
                          ),);
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator(color: Colors.orange,));
                        }

                        return ListView(
                          scrollDirection: Axis.horizontal,
                        children: snapshot.data.docs.map<Widget>((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                          return Padding(
                            padding:  EdgeInsets.all(10.0),
                            child: Container(
                              width:AppResponsive.isDesktop(context) || AppResponsive.isTablet(context)?MediaQuery.of(context).size.width/5:MediaQuery.of(context).size.width/2,
                              child: ProductItem(
                                  product:data
                              ),
                            ),
                          );
                        }).toList(),
                      );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10,right: 15,left: 15),
                    child: Divider(
                      height: 1,
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                  //advertisments
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/3,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3,bottom: 3,right: 15,left: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(),
                              Text("الأعلانات",style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2
                              ),),
                            ],
                          ),
                        ),
                        /////////////////////////////////////////
                        //here the advertisment carsoul
                        /////////////////////////////////////////
                        Expanded(
                          child: Container(
                            child: Carousel(
                              showIndicator: false,
                              images: [
                                NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                                NetworkImage('https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  //popular
                  Padding(
                    padding: EdgeInsets.only(top: 10,right: 15,left: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Text("أكثر المنتجات شهرة",style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // staggered Dual View
                  SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.7,
                      padding: EdgeInsets.only(top: 10),
                      child:StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("Product").snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('يوجد خطأ في تحميل الفئات',textAlign: TextAlign.center,style: TextStyle(
                                  color: Colors.orange
                              ),),
                            );
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator(color: Colors.orange,));
                          }
                          return StaggeredDualView(
                            aspectRatio:AppResponsive.isDesktop(context) || AppResponsive.isTablet(context)?0.9:0.7,
                            spacing: 30,
                            snapshot: snapshot,
                          );
                        },

                      ),
                    ),
                  ),

                ],
              ),
            ),
            ),
        ),
      ),
    );
  }
}
