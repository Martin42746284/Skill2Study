const User = require('./User.model');
const Universite = require('./Universite.model');
const Filiere = require('./Filiere.model');
const Parcours = require('./Parcours.model');
const ProfilAcademique = require('./ProfilAcademique.model');
const Settings = require('./Settings.model');
const UserSettings = require('./UserSettings.model');
const Testimonial = require('./Testimonial.model');
const Notification = require('./Notification.model');
const { Question, OptionReponse, SessionTest, Recommendation, Favori, RecommendationRules } = require('./TestOrientation.model');
const { Test, TestQuestion, SessionTestMulti } = require('./Test.model');

// User <-> ProfilAcademique (1:1)
User.hasOne(ProfilAcademique, { foreignKey: 'user_id', as: 'profil' });
ProfilAcademique.belongsTo(User, { foreignKey: 'user_id' });

// Universite <-> Filiere (1:N)
Universite.hasMany(Filiere, { foreignKey: 'universite_id', as: 'filieres' });
Filiere.belongsTo(Universite, { foreignKey: 'universite_id', as: 'universite' });

// Filiere <-> Parcours (1:N)
Filiere.hasMany(Parcours, { foreignKey: 'filiere_id', as: 'parcours' });
Parcours.belongsTo(Filiere, { foreignKey: 'filiere_id', as: 'filiere' });

// Question <-> OptionReponse (1:N)
Question.hasMany(OptionReponse, { foreignKey: 'question_id', as: 'options' });
OptionReponse.belongsTo(Question, { foreignKey: 'question_id', as: 'question' });

// User <-> SessionTest (1:N)
User.hasMany(SessionTest, { foreignKey: 'user_id', as: 'sessions' });
SessionTest.belongsTo(User, { foreignKey: 'user_id' });

// User <-> Recommendation (1:N)
User.hasMany(Recommendation, { foreignKey: 'user_id', as: 'recommendations' });
Recommendation.belongsTo(User, { foreignKey: 'user_id' });
Recommendation.belongsTo(Filiere, { foreignKey: 'filiere_id', as: 'filiere' });

// User <-> Favori <-> Filiere (N:M via Favori)
User.hasMany(Favori, { foreignKey: 'user_id' });
Favori.belongsTo(Filiere, { foreignKey: 'filiere_id', as: 'filiere' });

// User <-> Notification (1:N)
User.hasMany(Notification, { foreignKey: 'user_id', as: 'notifications' });
Notification.belongsTo(User, { foreignKey: 'user_id' });

// User <-> UserSettings (1:1)
User.hasOne(UserSettings, { foreignKey: 'user_id', as: 'settings' });
UserSettings.belongsTo(User, { foreignKey: 'user_id' });

// Test <-> TestQuestion <-> Question (N:M)
Test.hasMany(TestQuestion, { foreignKey: 'test_id', as: 'testQuestions' });
TestQuestion.belongsTo(Test, { foreignKey: 'test_id' });
TestQuestion.belongsTo(Question, { foreignKey: 'question_id', as: 'question' });
Question.hasMany(TestQuestion, { foreignKey: 'question_id' });

// User <-> SessionTestMulti (1:N)
User.hasMany(SessionTestMulti, { foreignKey: 'user_id', as: 'sessionTestMulti' });
SessionTestMulti.belongsTo(User, { foreignKey: 'user_id' });
SessionTestMulti.belongsTo(Test, { foreignKey: 'test_id', as: 'test' });

module.exports = { User, Universite, Filiere, Parcours, ProfilAcademique, Settings, UserSettings, Testimonial, Notification, Question, OptionReponse, SessionTest, Recommendation, Favori, RecommendationRules, Test, TestQuestion, SessionTestMulti };
