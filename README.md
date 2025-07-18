# File Structure

```
lib/
├── app/                          # App-level configuration
│   ├── app.dart                  # Main app widget
│   ├── router/                   # App routing
│   │   ├── app_router.dart
│   │   ├── routes.dart
│   │   └── route_guards.dart
│   ├── themes/                   # App theming
│   │   ├── app_theme.dart
│   │   ├── light_theme.dart
│   │   └── dark_theme.dart
│   └── config/                   # App configuration
│       ├── app_config.dart
│       └── environment.dart
│
├── core/                         # Core utilities and shared code
│   ├── constants/                # App constants
│   │   ├── api_constants.dart
│   │   ├── app_constants.dart
│   │   ├── colors.dart
│   │   ├── strings.dart
│   │   └── image_strings.dart
│   ├── extensions/               # Dart extensions
│   │   ├── context_extension.dart
│   │   ├── responsive_extension.dart
│   │   └── string_extension.dart
│   ├── utils/                    # Utility functions
│   │   ├── validators.dart
│   │   ├── helpers.dart
│   │   ├── date_utils.dart
│   │   └── file_utils.dart
│   ├── services/                 # Core services
│   │   ├── api_service.dart
│   │   ├── storage_service.dart
│   │   ├── notification_service.dart
│   │   └── connectivity_service.dart
│   ├── exceptions/               # Custom exceptions
│   │   ├── app_exception.dart
│   │   ├── network_exception.dart
│   │   └── storage_exception.dart
│   ├── network/                  # Network layer
│   │   ├── dio_client.dart
│   │   ├── interceptors/
│   │   │   ├── auth_interceptor.dart
│   │   │   └── logging_interceptor.dart
│   │   └── network_info.dart
│   ├── storage/                  # Local storage
│   │   ├── local_storage.dart
│   │   ├── cache_manager.dart
│   │   └── secure_storage.dart
│   ├── dependency_injection/     # DI setup
│   │   ├── injection_container.dart
│   │   └── service_locator.dart
│   └── base/                     # Base classes
│       ├── base_controller.dart
│       ├── base_state.dart
│       └── base_widget.dart
│
├── shared/                       # Shared widgets and components
│   ├── widgets/                  # Reusable widgets
│   │   ├── buttons/
│   │   │   ├── primary_button.dart
│   │   │   ├── secondary_button.dart
│   │   │   └── upload_download_button.dart
│   │   ├── inputs/
│   │   │   ├── custom_text_field.dart
│   │   │   ├── search_field.dart
│   │   │   └── dropdown_field.dart
│   │   ├── cards/
│   │   │   ├── info_card.dart
│   │   │   └── action_card.dart
│   │   ├── dialogs/
│   │   │   ├── confirmation_dialog.dart
│   │   │   ├── loading_dialog.dart
│   │   │   └── error_dialog.dart
│   │   ├── loaders/
│   │   │   ├── circular_loader.dart
│   │   │   ├── shimmer_loader.dart
│   │   │   └── skeleton_loader.dart
│   │   ├── navigation/
│   │   │   ├── bottom_nav_bar.dart
│   │   │   ├── app_bar.dart
│   │   │   └── drawer.dart
│   │   └── layout/
│   │       ├── responsive_layout.dart
│   │       ├── safe_area_wrapper.dart
│   │       └── scroll_wrapper.dart
│   ├── models/                   # Shared models
│   │   ├── api_response.dart
│   │   ├── user_model.dart
│   │   └── pagination_model.dart
│   └── mixins/                   # Shared mixins
│       ├── validation_mixin.dart
│       └── loading_mixin.dart
│
├── features/                     # Feature modules
│   ├── authentication/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── auth_remote_datasource.dart
│   │   │   │   └── auth_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── login_request.dart
│   │   │   │   ├── login_response.dart
│   │   │   │   └── user_model.dart
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── user_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart
│   │   │   └── usecases/
│   │   │       ├── login_usecase.dart
│   │   │       ├── logout_usecase.dart
│   │   │       └── check_auth_status_usecase.dart
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── auth_controller.dart
│   │       ├── screens/
│   │       │   ├── login_screen.dart
│   │       │   ├── register_screen.dart
│   │       │   └── forgot_password_screen.dart
│   │       └── widgets/
│   │           ├── login_form.dart
│   │           ├── social_login_buttons.dart
│   │           └── auth_wrapper.dart
│   │
│   ├── resume/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── resume_remote_datasource.dart
│   │   │   │   └── resume_local_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── resume_model.dart
│   │   │   │   ├── template_model.dart
│   │   │   │   └── resume_request.dart
│   │   │   └── repositories/
│   │   │       └── resume_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── resume_entity.dart
│   │   │   │   └── template_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── resume_repository.dart
│   │   │   └── usecases/
│   │   │       ├── create_resume_usecase.dart
│   │   │       ├── get_templates_usecase.dart
│   │   │       ├── get_recent_resumes_usecase.dart
│   │   │       └── download_resume_usecase.dart
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   ├── resume_controller.dart
│   │       │   └── template_controller.dart
│   │       ├── screens/
│   │       │   ├── resume_builder_screen.dart
│   │       │   ├── resume_list_screen.dart
│   │       │   └── template_selection_screen.dart
│   │       └── widgets/
│   │           ├── resume_form/
│   │           │   ├── personal_info_form.dart
│   │           │   ├── experience_form.dart
│   │           │   └── education_form.dart
│   │           ├── template_selector.dart
│   │           ├── resume_preview.dart
│   │           └── recent_resumes_list.dart
│   │
│   ├── interview/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── profile/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── dashboard/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── l10n/                         # Internationalization
│   ├── app_localizations.dart
│   ├── app_en.arb
│   ├── app_hi.arb
│   └── app_bn.arb
│
├── gen/                          # Generated files
│   ├── assets.gen.dart
│   └── colors.gen.dart
│
└── main.dart                     # Entry point
```

