# interview

lib/
│
├── main.dart
│
├── app/
│   ├── app.dart                   # MaterialApp + Routes
│   └── themes/                    # Light/Dark themes, styles
│       ├── app_theme.dart
│       ├── colors.dart
│       ├── fonts.dart
│       └── text_styles.dart
│
├── core/
│   ├── constants/                 # All constants
│   │   ├── app_strings.dart
│   │   ├── app_sizes.dart
│   │   ├── app_icons.dart
│   │   └── durations.dart
│   ├── utils/                     # Helper functions / extensions
│   │   ├── validators.dart
│   │   ├── helpers.dart
│   │   └── device_utils.dart
│   └── widgets/                   # Common reusable widgets
│       ├── dotted_button.dart
│       ├── app_button.dart
│       └── loading_indicator.dart
│
├── features/
│   ├── home/
│   │   ├── screens/
│   │   │   └── home_screen.dart
│   │   └── widgets/
│   │       ├── feature_container.dart
│   │       └── welcome_message.dart
│
│   ├── resume/
│   │   ├── models/
│   │   │   ├── resume_model.dart
│   │   │   └── skill_item.dart
│   │   ├── screens/
│   │   │   └── resume_form_screen.dart
│   │   ├── widgets/
│   │   │   ├── resume_input_field.dart
│   │   │   ├── skill_chip.dart
│   │   │   ├── skill_wrap.dart
│   │   │   ├── skill_selection_bottom_sheet.dart
│   │   │   └── category_selection_bottom_sheet.dart
│   │   └── data/
│   │       └── skill_categories.dart
│
│   ├── review/
│   │   ├── screens/
│   │   │   └── resume_review_screen.dart
│   │   └── widgets/
│   │       └── review_result_card.dart
│
│   ├── flashcards/
│   │   ├── models/
│   │   │   └── flashcard.dart
│   │   ├── screens/
│   │   │   └── flashcard_screen.dart
│   │   └── widgets/
│   │       ├── flashcard_view.dart
│   │       └── flashcard_controls.dart
│
│   ├── interview/
│   │   ├── screens/
│   │   │   └── mock_interview_screen.dart
│   │   └── widgets/
│   │       └── chat_bubble.dart
│
│   └── cold_mailer/
│       ├── screens/
│       │   └── cold_mail_template_screen.dart
│       └── widgets/
│           └── mail_preview_card.dart
│
├── data/
│   ├── local_storage/             # SharedPreferences or Hive
│   ├── api/                       # Network services (if any)
│   └── repository/                # Repositories for features
│
└── routes/
├── app_routes.dart
└── route_names.dart
