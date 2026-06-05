# Configuration du Service Email

## Option 1: Gmail (Recommandé pour Développement)

### Étapes:

1. **Activer 2FA sur votre compte Google**
   - Allez sur https://myaccount.google.com/
   - Sécurité → Authentification à 2 facteurs
   - Suivez les étapes

2. **Créer un mot de passe d'application**
   - Allez sur https://myaccount.google.com/apppasswords
   - Sélectionnez "Mail" et "Windows"
   - Google génère un mot de passe de 16 caractères
   - Copiez ce mot de passe

3. **Configurer les variables d'environnement** (backend/.env)
```bash
EMAIL_SERVICE=gmail
EMAIL_USER=votre-email@gmail.com
EMAIL_PASSWORD=votre-mot-de-passe-application
EMAIL_FROM=noreply@orientai.mg
CLIENT_URL=http://localhost:5173
```

4. **Tester l'envoi**
   - Redémarrez le serveur backend
   - Faites une inscription
   - Vérifiez que l'email arrive dans la boîte mail

---

## Option 2: Autre Fournisseur SMTP

Exemple avec Outlook/Hotmail:

```bash
EMAIL_SERVICE=outlook
EMAIL_HOST=smtp.outlook.com
EMAIL_PORT=587
EMAIL_SECURE=false
EMAIL_USER=votre-email@outlook.com
EMAIL_PASSWORD=votre-mot-de-passe
EMAIL_FROM=noreply@orientai.mg
CLIENT_URL=http://localhost:5173
```

---

## Option 3: Développement sans Email Réel

Si vous ne voulez pas configurer un vrai service email:

1. Décommentez les variables EMAIL
2. Les tokens s'afficheront en console du backend
3. Copiez le lien depuis la console et ouvrez-le dans votre navigateur

---

## Variables d'Environnement

| Variable | Description | Exemple |
|----------|-------------|---------|
| EMAIL_SERVICE | Service email | gmail, outlook |
| EMAIL_USER | Email d'envoi | user@gmail.com |
| EMAIL_PASSWORD | Mot de passe | app-password |
| EMAIL_HOST | Serveur SMTP | smtp.gmail.com |
| EMAIL_PORT | Port SMTP | 587 |
| EMAIL_SECURE | TLS/SSL | false (587) ou true (465) |
| EMAIL_FROM | Email d'expéditeur | noreply@orientai.mg |
| CLIENT_URL | URL frontend | http://localhost:5173 |

---

## Dépannage

**L'email ne s'envoie pas?**
- Vérifiez les variables d'environnement
- Vérifiez les logs du backend (`console.error`)
- Vérifiez que le mot de passe d'application est correct (Gmail)

**Redirigé vers /verify-email mais pas de lien?**
- Ouvrez la console du backend
- Cherchez `[EMAIL]` pour voir le lien généré
- Copiez le token et ouvrez le lien manuellement

**Comment tester en local sans email?**
- Laissez EMAIL_SERVICE vide
- Les tokens s'afficheront en console
- Copie le lien de la console et ouvre-le

---

## API Endpoints

- `POST /auth/register` - Inscription (avec email de vérification)
- `POST /auth/verify-email` - Vérifier l'email (token en body)
- `POST /auth/login` - Connexion (bloquée si email_verification=true et email non vérifié)

## Frontend Pages

- `/register` - Inscription
- `/verify-email?token=xxx` - Vérification d'email
- `/login` - Connexion
