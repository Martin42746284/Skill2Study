export interface User {
  id: number;
  name: string;
  email: string;
  date: string;
  status: "Actif" | "Inactif" | "Suspendu";
  role: "Étudiant" | "Admin";
  tests: number;
  serie: "Série C" | "Série D" | "Série A" | "Tech." | "-";
}

export const users: User[] = [
  { id: 1, name: "Mialy Rakoto", email: "mialy@email.mg", date: "26/02/2026", status: "Actif", role: "Étudiant", tests: 3, serie: "Série C" },
  { id: 2, name: "Hery Razafy", email: "hery@email.mg", date: "25/02/2026", status: "Actif", role: "Étudiant", tests: 2, serie: "Série D" },
  { id: 3, name: "Fanja Andria", email: "fanja@email.mg", date: "24/02/2026", status: "Actif", role: "Étudiant", tests: 1, serie: "Série A" },
  { id: 4, name: "Tiana Rabe", email: "tiana@email.mg", date: "23/02/2026", status: "Inactif", role: "Étudiant", tests: 0, serie: "Tech." },
  { id: 5, name: "Noro Randria", email: "noro@email.mg", date: "22/02/2026", status: "Actif", role: "Étudiant", tests: 4, serie: "Série C" },
  { id: 6, name: "Lanto Ratsimba", email: "lanto@email.mg", date: "21/02/2026", status: "Actif", role: "Admin", tests: 0, serie: "-" },
  { id: 7, name: "Voahirana Rina", email: "voahirana@email.mg", date: "20/02/2026", status: "Actif", role: "Étudiant", tests: 2, serie: "Série C" },
  { id: 8, name: "Andry Rasolofo", email: "andry@email.mg", date: "19/02/2026", status: "Suspendu", role: "Étudiant", tests: 1, serie: "Série D" },
];

export const getUserById = (id: number) => {
  return users.find((u) => u.id === id);
};

export const getUsersByRole = (role: "Étudiant" | "Admin") => {
  return users.filter((u) => u.role === role);
};

export const getUsersByStatus = (status: "Actif" | "Inactif" | "Suspendu") => {
  return users.filter((u) => u.status === status);
};

export const searchUsers = (query: string) => {
  const q = query.toLowerCase();
  return users.filter(
    (u) =>
      u.name.toLowerCase().includes(q) ||
      u.email.toLowerCase().includes(q)
  );
};
