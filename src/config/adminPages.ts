// Pages configuration avec clés de traduction
export const adminPages: Record<string, { titleKey: string; descriptionKey: string }> = {
  "/admin": {
    titleKey: "admin.dashboard",
    descriptionKey: "admin.statistics",
  },
  "/admin/users": {
    titleKey: "admin.pages.users.title",
    descriptionKey: "admin.pages.users.description",
  },
  "/admin/universities": {
    titleKey: "admin.pages.universities.title",
    descriptionKey: "admin.pages.universities.description",
  },
  "/admin/filieres": {
    titleKey: "admin.pages.filieres.title",
    descriptionKey: "admin.pages.filieres.description",
  },
  "/admin/tests": {
    titleKey: "admin.pages.tests.title",
    descriptionKey: "admin.pages.tests.description",
  },
  "/admin/testimonials": {
    titleKey: "admin.pages.testimonials.title",
    descriptionKey: "admin.pages.testimonials.description",
  },
  "/admin/settings": {
    titleKey: "admin.pages.settings.title",
    descriptionKey: "admin.pages.settings.description",
  },
};
