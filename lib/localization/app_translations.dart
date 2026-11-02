import 'app_language.dart';

class AppTranslations {
  AppTranslations._();

  static const Map<String, Map<String, String>> _values = {
    // General & App Shell
    'app_name': {
      'en': 'Smartify - A/L ICT',
      'si': 'ස්මාර්ටිෆයි - උ/පෙළ ICT',
      'ta': 'Smartify - உ/த ICT',
    },
    'app_subtitle': {
      'en': 'G.C.E. A/L ICT Smartify',
      'si': 'අ.පො.ස. උ/පෙළ තොරතුරු තාක්ෂණය',
      'ta': 'க.பொ.த உ/த தகவல் தொழினுட்பம்',
    },
    'examination_companion': {
      'en': 'G.C.E. A/L ICT Examination Companion',
      'si': 'අ.පො.ස. උ/පෙළ ICT විභාග සහායකයා',
      'ta': 'க.பொ.த உ/த ICT பரீட்சை வழிகாட்டி',
    },

    // Navigation Tabs
    'tab_quizzes': {
      'en': 'Quizzes',
      'si': 'ප්‍රශ්නාවලි',
      'ta': 'வினாடி வினா',
    },
    'tab_lessons': {
      'en': 'Lessons',
      'si': 'පාඩම් මාලාව',
      'ta': 'பாடங்கள்',
    },
    'tab_short_notes': {
      'en': 'Short Notes',
      'si': 'කෙටි සටහන්',
      'ta': 'குறுங்குறிப்புகள்',
    },
    'tab_past_papers': {
      'en': 'Past Papers',
      'si': 'පසුගිය ප්‍රශ්න පත්‍ර',
      'ta': 'கடந்த வினாத்தாள்கள்',
    },

    // Greetings
    'good_morning': {
      'en': 'Good morning',
      'si': 'සුබ උදෑසනක්',
      'ta': 'காலை வணக்கம்',
    },
    'good_afternoon': {
      'en': 'Good afternoon',
      'si': 'සුබ දහවලක්',
      'ta': 'மதிய வணக்கம்',
    },
    'good_evening': {
      'en': 'Good evening',
      'si': 'සුබ සන්ධ්‍යාවක්',
      'ta': 'மாலை வணக்கம்',
    },
    'student': {
      'en': 'Student',
      'si': 'සිසුවා',
      'ta': 'மாணவர்',
    },

    // Language Selector
    'language': {
      'en': 'Language',
      'si': 'භාෂාව',
      'ta': 'மொழி',
    },
    'select_language': {
      'en': 'Select Language',
      'si': 'භාෂාව තෝරන්න',
      'ta': 'மொழியைத் தேர்ந்தெடுக்கவும்',
    },

    // Home / Dashboard (quiz_page.dart)
    'practice_papers_quizzes': {
      'en': 'Practice Papers & Quizzes',
      'si': 'පුහුණු ප්‍රශ්න පත්‍ර සහ ප්‍රශ්නාවලි',
      'ta': 'பயிற்சி வினாத்தாள்கள் & வினாடி வினாக்கள்',
    },
    'select_type': {
      'en': 'Select Type',
      'si': 'වර්ගය තෝරන්න',
      'ta': 'வகையைத் தெரிவுசெய்க',
    },
    'special_announcement': {
      'en': 'Special Announcement',
      'si': 'විශේෂ නිවේදනය',
      'ta': 'சிறப்பு அறிவிப்பு',
    },
    'mcq_hub_title': {
      'en': 'MCQ Practice Hub',
      'si': 'බහුවරණ (MCQ) පුහුණු කේන්ද්‍රය',
      'ta': 'MCQ பயிற்சி மையம்',
    },
    'mcq_hub_subtitle': {
      'en': '50 Questions per year or practice by specific ICT topic',
      'si': 'වසර අනුව ප්‍රශ්න 50ක් හෝ විෂය ඒකක අනුව පුහුණුවන්න',
      'ta': 'வருடத்திற்கு 50 வினாக்கள் அல்லது தலைப்பு வாரியாக பயிற்சி',
    },
    'structured_essay_title': {
      'en': 'Structured Essay Questions',
      'si': 'ව්‍යුහගත රචනා ප්‍රශ්න',
      'ta': 'அமைப்புக் கட்டுரை வினாக்கள்',
    },
    'structured_essay_subtitle': {
      'en': 'Part A past paper question sets with step-by-step models',
      'si': 'පියවරෙන් පියවර ආදර්ශ පිළිතුරු සහිත පසුගිය විභාග ප්‍රශ්න',
      'ta': 'படிமுறை மாதிரிகளுடன் பகுதி A கடந்த கால வினாத் தொகுப்புகள்',
    },
    'essay_paper_title': {
      'en': 'Essay Paper & Models',
      'si': 'රචනා ප්‍රශ්න පත්‍ර සහ ආදර්ශ',
      'ta': 'கட்டுரைத் தாள்கள் & மாதிரிகள்',
    },
    'essay_paper_subtitle': {
      'en': 'Comprehensive algorithmic, networking & database essays',
      'si': 'ක්‍රමලේඛන, ජාලකරණ සහ දත්ත සමුදාය ගැඹුරු රචනා ප්‍රශ්න',
      'ta': 'படிமுறை, நெட்வொர்க்கிங் மற்றும் தரவுத்தள விரிவான கட்டுரைகள்',
    },
    'study_tip_title': {
      'en': 'A/L ICT Study Tip 💡',
      'si': 'උ/පෙළ ICT අධ්‍යයන උපදෙස 💡',
      'ta': 'உ/த ICT படிப்பு உதவிக்குறிப்பு 💡',
    },
    'study_tip_desc': {
      'en': 'Reviewing marking schemes reveals exact keyword rubrics examiners look for in Part II questions.',
      'si': 'ලකුණු දීමේ පටිපාටිය පරිශීලනය කිරීමෙන් පරීක්ෂකවරුන් අපේක්ෂා කරන මූල පද නිවැරදිව හඳුනාගත හැක.',
      'ta': 'புள்ளி வழங்கும் திட்டத்தை மதிப்பாய்வு செய்வது பகுதி II வினாக்களில் எதிர்பார்க்கப்படும் முக்கிய சொற்களை வெளிப்படுத்துகிறது.',
    },

    // MCQ Hub Page
    'exam_mode_title': {
      'en': 'A/L ICT Examination Mode',
      'si': 'උ/පෙළ ICT විභාග ක්‍රමය',
      'ta': 'உ/த ICT பரீட்சை முறைமை',
    },
    'exam_mode_desc': {
      'en': 'Choose between full-length past papers by year or target specific weak syllabus units.',
      'si': 'සම්පූර්ණ පසුගිය විභාග ප්‍රශ්න පත්‍ර හෝ තෝරාගත් ඒකක අනුව පුහුණුවන්න.',
      'ta': 'முழுமையான கடந்தகால தாள்கள் அல்லது குறிப்பிட்ட பாட அலகுகளைத் தேர்ந்தெடுக்கவும்.',
    },
    'select_practice_mode': {
      'en': 'Select Practice Mode',
      'si': 'පුහුණු ආකාරය තෝරන්න',
      'ta': 'பயிற்சி முறையைத் தேர்ந்தெடுக்கவும்',
    },
    'mcq_by_year_title': {
      'en': 'Past Paper MCQs via Year',
      'si': 'වසර අනුව පසුගිය විභාග MCQ',
      'ta': 'வருட வாரியான கடந்தகால MCQ',
    },
    'mcq_by_year_desc': {
      'en': 'Authentic 50-question examination papers from 2021 to 2015 with timed evaluation.',
      'si': '2015 සිට 2021 දක්වා නිල ප්‍රශ්න 50ක විභාග ප්‍රශ්න පත්‍ර සහ කාල ගණනය.',
      'ta': '2021 முதல் 2015 வரையிலான 50 வினாக்கள் கொண்ட உத்தியோகபூர்வ தாள்கள்.',
    },
    'browse_years': {
      'en': 'Browse Years (2015 - 2021)',
      'si': 'වසර තෝරන්න (2015 - 2021)',
      'ta': 'வருடங்களை உலாவுக (2015 - 2021)',
    },
    'mcq_by_topic_title': {
      'en': 'Categorized by Syllabus Topic',
      'si': 'විෂය ඒකක අනුව වර්ගීකෘත MCQ',
      'ta': 'பாடத்திட்ட தலைப்பு வாரியாக வகைப்படுத்தப்பட்டது',
    },
    'mcq_by_topic_desc': {
      'en': 'Target specific competencies: Python, SQL, Boolean Algebra, Networking, IoT, and more.',
      'si': 'පයිතන්, SQL, බූලීය වීජ ගණිතය, ජාලකරණය, IoT වැනි විශේෂිත ඒකක පුහුණුවන්න.',
      'ta': 'குறிப்பிட்ட திறன்களை இலக்கு வைக்கவும்: Python, SQL, Networking, IoT மற்றும் பல.',
    },
    'select_topic_btn': {
      'en': 'Select Syllabus Topic',
      'si': 'විෂය ඒකකය තෝරන්න',
      'ta': 'பாடத்திட்ட தலைப்பைத் தேர்ந்தெடுக்கவும்',
    },

    // Past Papers Page
    'past_papers_banner_title': {
      'en': 'Past Papers & Marking Schemes 📚',
      'si': 'පසුගිය ප්‍රශ්න පත්‍ර සහ ලකුණු දීමේ පටිපාටි 📚',
      'ta': 'கடந்த வினாத்தாள்கள் & புள்ளி வழங்கும் திட்டங்கள் 📚',
    },
    'past_papers_banner_desc': {
      'en': 'Access authentic Department of Examinations Sri Lanka past question papers with official marking points.',
      'si': 'ශ්‍රී ලංකා විභාග දෙපාර්තමේන්තුවේ නිල පසුගිය විභාග ප්‍රශ්න පත්‍ර සහ ලකුණු පටිපාටි.',
      'ta': 'இலங்கை பரீட்சைத் திணைக்களத்தின் உத்தியோகபூர்வ வினாத்தாள்கள் மற்றும் புள்ளித் திட்டங்கள்.',
    },
    'mcq_papers': {
      'en': 'MCQ Papers',
      'si': 'MCQ පත්‍ර',
      'ta': 'MCQ தாள்கள்',
    },
    'structured': {
      'en': 'Structured',
      'si': 'ව්‍යුහගත',
      'ta': 'அமைப்புக்கட்டுரை',
    },
    'essay_papers': {
      'en': 'Essay Papers',
      'si': 'රචනා පත්‍ර',
      'ta': 'கட்டுரைத் தாள்கள்',
    },
    'national_archives': {
      'en': 'National Exam Archives (2015 - 2021)',
      'si': 'ජාතික විභාග ප්‍රශ්න පත්‍ර එකතුව (2015 - 2021)',
      'ta': 'தேசிய பரீட்சைக் காப்பகங்கள் (2015 - 2021)',
    },
    'question_paper': {
      'en': 'Question Paper',
      'si': 'ප්‍රශ්න පත්‍රය',
      'ta': 'வினாத்தாள்',
    },
    'marking_scheme': {
      'en': 'Marking Scheme',
      'si': 'ලකුණු පටිපාටිය',
      'ta': 'புள்ளித் திட்டம்',
    },
    'view_pdf': {
      'en': 'View PDF',
      'si': 'PDF බලන්න',
      'ta': 'PDF காண்க',
    },
    'new_syllabus': {
      'en': 'New Syllabus',
      'si': 'නව නිර්දේශය',
      'ta': 'புதிய பாடத்திட்டம்',
    },

    // Lessons Page
    'syllabus_lessons_title': {
      'en': 'Syllabus Lessons & Units 📖',
      'si': 'විෂය නිර්දේශයේ පාඩම් සහ ඒකක 📖',
      'ta': 'பாடத்திட்ட பாடங்கள் & அலகுகள் 📖',
    },
    'syllabus_lessons_desc': {
      'en': 'Complete 12-unit G.C.E. A/L ICT curriculum with key concepts and targeted MCQs.',
      'si': 'අ.පො.ස. උ/පෙළ ICT ඒකක 12ම මූලික සංකල්ප සහ ප්‍රශ්න සමඟ.',
      'ta': 'முழுமையான 12-அலகு க.பொ.த உ/த ICT பாடத்திட்டம் முக்கிய கருத்துக்களுடன்.',
    },
    'curriculum_units': {
      'en': 'Curriculum Units (Units 01 to 12)',
      'si': 'විෂය නිර්දේශ ඒකක (ඒකක 01 සිට 12 දක්වා)',
      'ta': 'பாடத்திட்ட அலகுகள் (அலகுகள் 01 முதல் 12 வரை)',
    },
    'practice_unit_mcqs': {
      'en': 'Practice Unit MCQs',
      'si': 'මෙම ඒකකයේ MCQ පුහුණුවන්න',
      'ta': 'அலகு MCQ பயிற்சி செய்க',
    },

    // Short Notes Page
    'short_notes_banner_title': {
      'en': 'A/L ICT Short Notes & Cheatsheets 📝',
      'si': 'උ/පෙළ ICT කෙටි සටහන් සහ සූත්‍ර 📝',
      'ta': 'உ/த ICT குறிப்புகள் & சுருக்கங்கள் 📝',
    },
    'short_notes_banner_desc': {
      'en': 'Rapid revision summaries, formula sheets, logic diagrams, and memory aids.',
      'si': 'කඩිනම් පුනරීක්ෂණ සාරාංශ, සූත්‍ර පත්‍රිකා, තාර්කික රූපසටහන් සහ මතක සටහන්.',
      'ta': 'துரித திருத்தல் சுருக்கங்கள், சூத்திரத் தாள்கள் மற்றும் வரைபடங்கள்.',
    },
    'high_yield_topics': {
      'en': 'High-Yield Revision Topics',
      'si': 'විශේෂ පුනරීක්ෂණ මාතෘකා',
      'ta': 'முக்கிய திருத்தல் தலைப்புகள்',
    },
    'core_summary_theory': {
      'en': 'Core Summary & Theory',
      'si': 'මූලික සාරාංශය සහ න්‍යාය',
      'ta': 'முக்கிய சுருக்கம் & கோட்பாடு',
    },
    'key_formulas_rules': {
      'en': 'Key Formulas & Examination Rules',
      'si': 'ප්‍රධාන සූත්‍ර සහ විභාග නීති',
      'ta': 'முக்கிய சூத்திரங்கள் & பரீட்சை விதிகள்',
    },
    'open_companion_pdf': {
      'en': 'Open Companion PDF Cheatsheet',
      'si': 'අදාළ PDF කෙටි සටහන බලන්න',
      'ta': 'இணைப்பு PDF சுருக்கத்தை திறக்கவும்',
    },

    // Quiz Play Engine
    'question': {
      'en': 'Question',
      'si': 'ප්‍රශ්නය',
      'ta': 'வினா',
    },
    'of': {
      'en': 'of',
      'si': '/',
      'ta': '/',
    },
    'score': {
      'en': 'Score',
      'si': 'ලකුණු',
      'ta': 'மதிப்பெண்',
    },
    'zoom': {
      'en': 'Zoom',
      'si': 'විශාල කරන්න',
      'ta': 'பெரிதாக்கு',
    },
    'view_explanation': {
      'en': 'View Detailed Explanation & Working',
      'si': 'සවිස්තරාත්මක පැහැදිලි කිරීම සහ ක්‍රමය බලන්න',
      'ta': 'விரிவான விளக்கம் மற்றும் வழியைப் பார்க்கவும்',
    },
    'hide_explanation': {
      'en': 'Hide Explanation',
      'si': 'පැහැදිලි කිරීම සඟවන්න',
      'ta': 'விளக்கத்தை மறைக்கவும்',
    },
    'marking_scheme_working': {
      'en': 'Marking Scheme Working',
      'si': 'ලකුණු දීමේ ක්‍රමය',
      'ta': 'புள்ளித் திட்டத்தின் தீர்வு',
    },
    'previous': {
      'en': 'Previous',
      'si': 'පෙර',
      'ta': 'முந்தைய',
    },
    'next': {
      'en': 'Next',
      'si': 'ඊළඟ',
      'ta': 'அடுத்து',
    },
    'finish_quiz': {
      'en': 'Finish Quiz',
      'si': 'අවසන් කරන්න',
      'ta': 'முடிக்கவும்',
    },
    'question_overview': {
      'en': 'Question Overview',
      'si': 'ප්‍රශ්න දළ විශ්ලේෂණය',
      'ta': 'வினா மேலோட்டம்',
    },
    'correct': {
      'en': 'Correct',
      'si': 'නිවැරදි',
      'ta': 'சரி',
    },
    'wrong': {
      'en': 'Wrong',
      'si': 'වැරදි',
      'ta': 'தவறு',
    },
    'skipped': {
      'en': 'Skipped',
      'si': 'මඟහැරි',
      'ta': 'தவிர்க்கப்பட்டது',
    },
    'quiz_completed': {
      'en': 'Quiz Completed! 🎉',
      'si': 'ප්‍රශ්නාවලිය සම්පූර්ණයි! 🎉',
      'ta': 'வினாடி வினா முடிந்தது! 🎉',
    },
    'grade': {
      'en': 'Grade',
      'si': 'සාමාර්ථය',
      'ta': 'தரம்',
    },
    'review_answers': {
      'en': 'Review Answers',
      'si': 'පිළිතුරු සමාලෝචනය',
      'ta': 'விடைகளை மதிப்பாய்வு செய்க',
    },
    'exit_quiz': {
      'en': 'Exit Quiz',
      'si': 'ඉවත් වන්න',
      'ta': 'வெளியேறு',
    },
    'no_questions_title': {
      'en': 'No Questions Available',
      'si': 'ප්‍රශ්න ලබාගත නොහැක',
      'ta': 'வினாக்கள் கிடைக்கவில்லை',
    },
    'no_questions_desc': {
      'en': 'Questions for this section are being updated in the cloud database. Please try another year or category.',
      'si': 'මෙම කොටසේ ප්‍රශ්න යාවත්කාලීන වෙමින් පවතී. කරුණාකර වෙනත් වසරක් හෝ ඒකකයක් තෝරන්න.',
      'ta': 'இந்த பகுதிக்கான வினாக்கள் புதுப்பிக்கப்படுகின்றன. தயவுசெய்து வேறு வருடத்தை முயற்சிக்கவும்.',
    },
    'back_to_hub': {
      'en': 'Back to MCQ Hub',
      'si': 'MCQ මෙනුවට ආපසු',
      'ta': 'MCQ மையத்திற்குத் திரும்பவும்',
    },

    // Profile Screen
    'student_profile': {
      'en': 'Student Profile',
      'si': 'ශිෂ්‍ය ගිණුම',
      'ta': 'மாணவர் சுயவிவரம்',
    },
    'al_candidate_badge': {
      'en': '🎓 G.C.E. Advanced Level ICT Candidate',
      'si': '🎓 අ.පො.ස. උසස් පෙළ ICT අපේක්ෂක',
      'ta': '🎓 க.பொ.த உயர்தர ICT பரீட்சார்த்தி',
    },
    'study_overview': {
      'en': 'Study Overview',
      'si': 'අධ්‍යයන වාර්තාව',
      'ta': 'படிப்பு மேலோட்டம்',
    },
    'mcq_bank': {
      'en': 'MCQ Bank',
      'si': 'ප්‍රශ්න සංචිතය',
      'ta': 'MCQ வங்கி',
    },
    'curriculum': {
      'en': 'Curriculum',
      'si': 'විෂය නිර්දේශය',
      'ta': 'பாடத்திட்டம்',
    },
    'past_papers_stat': {
      'en': 'Past Papers',
      'si': 'පසුගිය ප්‍රශ්න',
      'ta': 'கடந்த தாள்கள்',
    },
    'examination_target': {
      'en': 'Examination Target',
      'si': 'ඉලක්කගත විභාගය',
      'ta': 'இலக்கு பரீட்சை',
    },
    'sl_exam_desc': {
      'en': 'Sri Lanka G.C.E. A/L Examination',
      'si': 'ශ්‍රී ලංකා අ.පො.ස. උ/පෙළ විභාගය',
      'ta': 'இலங்கை க.பொ.த உ/த பரீட்சை',
    },
    'app_language_setting': {
      'en': 'App Language',
      'si': 'යෙදුමේ භාෂාව (Language)',
      'ta': 'பயன்பாட்டு மொழி (Language)',
    },
    'about_smartify': {
      'en': 'About Smartify',
      'si': 'Smartify පිළිබඳව',
      'ta': 'Smartify பற்றி',
    },
    'sign_out': {
      'en': 'Sign Out',
      'si': 'පිටවීම',
      'ta': 'வெளியேறு',
    },
    'sign_out_account': {
      'en': 'Sign Out from Account',
      'si': 'ගිණුමෙන් පිටවන්න',
      'ta': 'கணக்கிலிருந்து வெளியேறு',
    },
    'sign_out_confirm_msg': {
      'en': 'Are you sure you want to sign out from Smartify?',
      'si': 'ඔබට Smartify ගිණුමෙන් පිටවීමට අවශ්‍ය බව සහතිකද?',
      'ta': 'Smartify இலிருந்து நிச்சயமாக வெளியேற விரும்புகிறீர்களா?',
    },
    'cancel': {
      'en': 'Cancel',
      'si': 'අවලංගු කරන්න',
      'ta': 'ரத்துசெய்',
    },

    // Auth Screen
    'welcome_title': {
      'en': 'Welcome to Smartify',
      'si': 'Smartify වෙත සාදරයෙන් පිළිගනිමු',
      'ta': 'Smartify க்கு வரவேற்கிறோம்',
    },
    'welcome_desc': {
      'en': 'Your smart partner for Sri Lankan G.C.E. A/L ICT excellence',
      'si': 'ශ්‍රී ලංකා අ.පො.ස. උ/පෙළ ICT විභාගයේ විශිෂ්ටත්වය සඳහා ඔබේ සහකරු',
      'ta': 'இலங்கை க.பொ.த உ/த ICT பரீட்சை சிறப்புக்கான உங்கள் வழிகாட்டி',
    },
    'continue_google': {
      'en': 'Continue with Google',
      'si': 'Google සමඟ ඉදිරියට යන්න',
      'ta': 'Google உடன் தொடரவும்',
    },

    // Exit Dialog
    'exit_title': {
      'en': 'Exit Smartify?',
      'si': 'Smartify වෙතින් ඉවත් වෙනවාද?',
      'ta': 'Smartify இலிருந்து வெளியேறவா?',
    },
    'exit_desc': {
      'en': 'Do you really want to close the app? Your quiz progress in completed sessions is safely saved.',
      'si': 'යෙදුම වැසීමට ඔබට අවශ්‍යද? ඔබ අවසන් කළ ප්‍රශ්නාවලි තොරතුරු සුරක්ෂිතව ඇත.',
      'ta': 'செயலியை மூட விரும்புகிறீர்களா? முடித்த வினாடி வினாக்கள் பாதுகாப்பாக சேமிக்கப்பட்டுள்ளன.',
    },
    'stay': {
      'en': 'Stay',
      'si': 'රැඳෙන්න',
      'ta': 'தொடரவும்',
    },
    'exit': {
      'en': 'Exit',
      'si': 'ඉවත් වන්න',
      'ta': 'வெளியேறு',
    },
  };

  // Syllabus Unit Titles in 3 Languages
  static const Map<String, Map<String, String>> unitTitles = {
    'Unit 01': {
      'en': 'Basic Concepts of ICT',
      'si': 'තොරතුරු සහ සන්නිවේදන තාක්ෂණයේ මූලික සංකල්ප',
      'ta': 'தகவல் தொடர்பாடல் தொழினுட்பத்தின் அடிப்படைக் கருத்துக்கள்',
    },
    'Unit 02': {
      'en': 'Evolution of Computing',
      'si': 'පරිගණකයේ පරිණාමය',
      'ta': 'கணினிமயமாக்கலின் பரிணாமம்',
    },
    'Unit 03': {
      'en': 'Data Representation & Number Systems',
      'si': 'දත්ත නිරූපණය සහ සංඛ්‍යා පද්ධති',
      'ta': 'தரவு வகைகுறிப்பும் எண்முறைகளும்',
    },
    'Unit 04': {
      'en': 'Digital Logic & Boolean Algebra',
      'si': 'අංකිත තාර්කික සහ බූලීය වීජ ගණිතය',
      'ta': 'இலக்கமுறை தர்க்கமும் பூலியன் இயற்கணிதமும்',
    },
    'Unit 05': {
      'en': 'Operating Systems & System Software',
      'si': 'මෙහෙයුම් පද්ධති සහ පද්ධති මෘදුකාංග',
      'ta': 'தொழிற்பாட்டு முறைமைகளும் முறைமை மென்பொருளும்',
    },
    'Unit 06': {
      'en': 'Data Communication & Computer Networks',
      'si': 'දත්ත සන්නිවේදනය සහ පරිගණක ජාල',
      'ta': 'தரவுத் தொடர்பாடலும் கணினி வலைப்பின்னல்களும்',
    },
    'Unit 07': {
      'en': 'Systems Analysis & Design (SAD)',
      'si': 'පද්ධති විග්‍රහය සහ නිර්මාණය',
      'ta': 'முறைமைப் பகுப்பாய்வும் வடிவமைப்புமும்',
    },
    'Unit 08': {
      'en': 'Database Management Systems (DBMS)',
      'si': 'දත්ත සමුදාය කළමනාකරණ පද්ධති',
      'ta': 'தரவுத்தள முகாமைத்துவ முறைமைகள்',
    },
    'Unit 09': {
      'en': 'Programming with Python',
      'si': 'පයිතන් ක්‍රමලේඛනය',
      'ta': 'பைத்தன் நிரலாக்கம்',
    },
    'Unit 10': {
      'en': 'Web Development (HTML/CSS/JS/PHP)',
      'si': 'වෙබ් සංවර්ධනය',
      'ta': 'வலை உருவாக்கம்',
    },
    'Unit 11': {
      'en': 'Internet of Things (IoT)',
      'si': 'භාණ්ඩ අන්තර්ජාලය (IoT)',
      'ta': 'பொருட்களின் இணையம் (IoT)',
    },
    'Unit 12': {
      'en': 'ICT in Business & Emerging Trends',
      'si': 'ව්‍යාපාර තුළ ICT සහ නවීන ප්‍රවණතා',
      'ta': 'வணிகத்தில் ICT மற்றும் புதிய போக்குகள்',
    },
  };

  static String get(String key, AppLanguage language) {
    final entry = _values[key];
    if (entry == null) return key;
    return entry[language.code] ?? entry['en'] ?? key;
  }

  static String getUnitTitle(String unitKey, AppLanguage language, String defaultTitle) {
    final entry = unitTitles[unitKey];
    if (entry == null) return defaultTitle;
    return entry[language.code] ?? entry['en'] ?? defaultTitle;
  }
}
