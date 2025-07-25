class AppStrings {
  static const hi = "Hello";
  static const name = "Roopam!";
  static const ad = "ADVERTISEMENT";

  static const crackIt = "< crack the interview />";
  static const finalSteps = "Final Steps Toward Your Goal";

  // Bottom Navigation Labels
  static const String navInterviews = 'Interviews';
  static const String navFlashCards = 'Flash Cards';
  static const String navProfile = 'Profile';
  static const String navHome = 'Home';

  //finished-interview
  static const String mockInterviewCompletedTitle = 'Congratulations';
  static const String mockInterviewCompletedMessage =
      'You have completed your mock interview for';
  static const String back = 'BACK';
  static const String interviewReport = 'Interview Report';

  //Card-Text
  static const buildYourResumeTitle = "Build Your Resume";
  static const resumeBuilder = "Resume Builder";
  static const buildYourResumeSubtitle = "‹ your quick resume builder / ›";

  static const resumeReviewTitle = "Resume Review";
  static const resumeReviewSubtitle = "< know your feedback />";

  static const flashcardPracticeTitle = "Practice Flash Card";
  static const flashcard = "Flash Card";
  static const flashcardPracticeSubtitle = "< for your quick revision />";

  static const mockInterviewTitle = "Take Mock Interview";
  static const mockInterviewSubtitle = "< real time interview />";

  static const coldMailTitle = "Cold Mail";
  static const coldMailSubtitle = "< to the recruiters />";

  //resume builder texts
  static const preview = "Preview";
  static const resumePDF = "Resume PDFs";
  static const templates = "Templates";

  //General Information
  static const generalInformation = "General Information";
  static const buildYourResume = "Build Your Resume";
  static const firstName = "First Name";
  static const lastName = "Last Name";
  static const shortBio = "Short Bio";
  static const yearsOfExperience = "Years Of Experience";

  //hint-Texts
  static const hintFirstName = "Enter your first name";
  static const hintLastName = "Enter your last name";
  static const bio = "Write a short bio about yourself";
  static const experience = "Enter years of experience";

  //Contact Form
  static const contactForm = "Contact Form";
  static const basedOutOf = "Based Out Of";
  static const phn = "Phone Number";
  static const email = "Email";

  //hint-Texts
  static const hintCityOrLocation = "Enter your city or location";
  static const hintEmail = "Enter your email";
  static const hintPhn = "Enter your phone number";

  //social links
  static const socialLink = "Social Links";
  static const portfolio = "portfolio website";
  static const linkedIn = "linkedIn";
  static const github = "github profile";
  static const codingProfile = "Coding Profile";

  //social links
  static const pasteLink = "Paste Link";

  // Work Experience
  static const workExperience = "Work Experience";
  static const jobTitle = "Job Title";
  static const company = "Company";
  static const jobDescription = "Job Description";
  static const from = "FROM: ";
  static const to = "TO: ";
  static const stillWorkHere = "Still working here?";
  static const removeExperience = "Remove this experience";
  static const select = "Select";
  static const addExperience = "Add Experience";

  //review review
  static const runPrompts = "Run Prompts";
  static const uploadResume = "Upload Your Resume(.pdf)";
  static const provideJD = "Please provide JD and upload resume";
  static const aboutResume = "Tell me about the resume";
  static const improviseSkill = "How can I improvise my skills?";
  static const missingKeywords = "What are the keywords that are missing?";
  static const percentageMatch = "Percentage Match";
  static const pasteJobDesc = "Paste Job Description";

  //profile
  static const menu = "Menu";
  static const logOut = "Log out";
  static const settings = "settings";
  static const profile = "profile";

  //mock-interview
  static const mockInterview = "Select an Interview Template";
  static const String failedToLoadInterviews = 'Failed to load interview items. Please try again.';
  static const String customCompany = 'Custom Company';

  //membership
  // static const membershipSubTitle = "Only ${"perMonth"} per month";

  //dialog box
  static const alertTitle = "Final Step";
  static const alertSubTitle = "Have you filled in all your details correctly?";
  static const alertYes = "Yes,Proceed";
  static const alertNo = "No";
  static const alertStart = "Start";
  static const alertCancel = "Cancel";

  // Animation index constants for better maintainability
  static const int welcomeMessageAnimationIndex = 0;
  static const int welcomeCardAnimationIndex = 1;
  static const int featuresListStartIndex = 2;
  static const int adSectionAnimationIndex = 7;

  //quiz
  //quiz completion dialog
  static const quizCompleteTitle = 'Quiz Complete!';
  static const backToTopics = 'Back to Topics';
  static const restartQuiz = 'Restart Quiz';
  static const known = 'Known';
  static const toReview = 'To Review';
  static String quizCompletedMessage(String topic) => 'You completed $topic quiz!';

  //mock-interview
  static const topic = 'TOPIC:';
  static const noInterviewsFound = 'No interviews found for';
  static const noInterviewsAvailable = 'No interviews available';
  static const searchHint = 'Search interviews...';
  static const recentSearches = 'Recent Searches';
  static const starting = 'Starting';
  static const interviewStart = 'interview...';
  static const adjustCategory = 'Try adjusting your search or category filter';
  static String interviewCreated(String title) =>
      'Custom interview "$title" created successfully!';
  //create interview
  static const createCustomInterview = 'Create Custom Interview';
  static const jobTitleLabel = 'Job Title *';
  static const jobTitleHint = 'e.g., Senior Flutter Developer';
  static const jobTitleValidation = 'Job title is required';

  static const companyLabel = 'Company (Optional)';
  static const companyHint = 'e.g., Google, Meta, Startup';

  static const jobDescriptionLabel = 'Job Description *';
  static const jobDescriptionHint =
      'Describe the role, responsibilities, and requirements...';
  static const jobDescriptionValidation = 'Job description is required';

  static const difficultyLevel = 'Difficulty Level';
  static const interviewDuration = 'Interview Duration';

  static const interviewTopicsLabel = 'Interview Topics *';
  static const interviewTopicsHint =
      'Select topics you want to be interviewed on:';

  static const addCustomTopicHint = 'Add custom topic...';

  static const topicsSelected = 'topics selected';
  static const selectAtLeastOneTopic = 'Please select at least one topic';

  static const createInterview = 'Create Interview';

}
