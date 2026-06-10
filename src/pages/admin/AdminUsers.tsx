import AdminLayout from "@/components/AdminLayout";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog";
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from "@/components/ui/alert-dialog";
import {
  Users,
  Search,
  UserPlus,
  MoreHorizontal,
  Eye,
  Pencil,
  Trash2,
  Download,
  Filter,
} from "lucide-react";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { useState, useEffect } from "react";
import { useTranslation } from "react-i18next";
import { useToast } from "@/hooks/use-toast";
import { admin } from "@/lib/api";
import { downloadCSV } from "@/lib/export";
import type { User } from "@/types";

const AdminUsers = () => {
  const { t } = useTranslation();
  const { toast } = useToast();
  const [search, setSearch] = useState("");
  const [statusFilter, setStatusFilter] = useState("all");
  const [users, setUsers] = useState<User[]>([]);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [viewDialogOpen, setViewDialogOpen] = useState(false);
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
  const [editingUser, setEditingUser] = useState<User | null>(null);
  const [viewingUser, setViewingUser] = useState<User | null>(null);
  const [deletingUserId, setDeletingUserId] = useState<number | null>(null);
  const [loading, setLoading] = useState(true);

  // Form state
  const [formName, setFormName] = useState("");
  const [formEmail, setFormEmail] = useState("");
  const [formRole, setFormRole] = useState<"Étudiant" | "Admin">("Étudiant");
  const [formSerie, setFormSerie] = useState<"Série C" | "Série D" | "Série A" | "Tech." | "-">("Série C");
  const [formStatus, setFormStatus] = useState<"Actif" | "Inactif" | "Suspendu">("Actif");

  useEffect(() => {
    const fetchUsers = async () => {
      try {
        setLoading(true);
        const response = await admin.getUsers(1, 100) as any;
        const users = response?.data || response?.users || [];

        if (Array.isArray(users)) {
          const formattedUsers = users.map((u: any) => ({
            id: u.id,
            name: `${u.prenom || ''} ${u.nom || ''}`.trim() || 'Sans nom',
            email: u.email || '',
            role: u.role === 'admin' ? 'Admin' : 'Étudiant',
            serie: u.serie_bac || '-',
            status: u.actif ? 'Actif' : 'Inactif',
            date: u.date_creation ? new Date(u.date_creation).toLocaleDateString('fr-FR') : 'N/A',
            tests: u.tests_passes || 0,
          }));
          setUsers(formattedUsers);
        }
      } catch (error) {
        toast({
          title: "Erreur",
          description: error instanceof Error ? error.message : "Impossible de charger les utilisateurs",
          variant: "destructive"
        });
      } finally {
        setLoading(false);
      }
    };

    fetchUsers();
  }, [toast]);

  const filtered = users.filter((u) => {
    const matchSearch = u.name.toLowerCase().includes(search.toLowerCase()) || u.email.toLowerCase().includes(search.toLowerCase());
    const matchStatus = statusFilter === "all" || u.status === statusFilter;
    return matchSearch && matchStatus;
  });

  const handleExportCSV = () => {
    const data = users.map(u => ({
      ID: u.id,
      Nom: u.name,
      Email: u.email,
      Rôle: u.role,
      'Série Bac': u.serie,
      Tests: u.tests,
      Statut: u.status,
      'Date Inscription': u.date,
    }));
    downloadCSV(data, `utilisateurs-${new Date().toLocaleDateString('fr-FR')}.csv`);
    toast({ title: t("common.success"), description: `${users.length} ${t("admin.pages.users.noResults").toLowerCase()}` });
  };

  const openAddDialog = () => {
    setEditingUser(null);
    setFormName(""); setFormEmail(""); setFormRole("Étudiant"); setFormSerie("Série C"); setFormStatus("Actif");
    setDialogOpen(true);
  };

  const openEditDialog = (user: User) => {
    setEditingUser(user);
    setFormName(user.name);
    setFormEmail(user.email);
    setFormRole(user.role as "Étudiant" | "Admin");
    setFormSerie(user.serie as "Série C" | "Série D" | "Série A" | "Tech." | "-");
    setFormStatus(user.status as "Actif" | "Inactif" | "Suspendu");
    setDialogOpen(true);
  };

  const handleSave = async () => {
    try {
      if (editingUser) {
        // Update existing user
        const updateData: any = {
          nom: formName.split(' ')[0] || formName,
          prenom: formName.includes(' ') ? formName.split(' ').slice(1).join(' ') : '',
          email: formEmail,
          role: formRole === 'Admin' ? 'admin' : 'bachelier',
          serie_bac: formSerie,
          actif: formStatus === 'Actif' ? true : formStatus === 'Inactif' ? false : undefined,
        };

        const response = await admin.updateUser(editingUser.id, updateData) as any;
        const updatedUserData = response?.user;

        const updatedUser = {
          ...editingUser,
          name: formName,
          email: formEmail,
          role: formRole,
          serie: formSerie,
          status: formStatus,
        };
        setUsers(users.map((u) => (u.id === editingUser.id ? updatedUser : u)));
        toast({ title: t("admin.pages.users.editUser"), description: `${formName} ${t("admin.pages.users.editUser").toLowerCase()}` });
      } else {
        // Create new user
        const createData: any = {
          nom: formName.split(' ')[0] || formName,
          prenom: formName.includes(' ') ? formName.split(' ').slice(1).join(' ') : '',
          email: formEmail,
          mot_de_passe: 'Password123!',
          role: formRole === 'Admin' ? 'admin' : 'bachelier',
          serie_bac: formSerie,
          actif: formStatus === 'Actif' ? true : false,
        };

        const response = await admin.createUser(createData) as any;
        const newUserData = response?.user;

        const now = new Date();
        const dateStr = now.toLocaleDateString('fr-FR');
        const newUser = {
          id: newUserData?.id || Math.max(...users.map((u: any) => u.id), 0) + 1,
          name: formName,
          email: formEmail,
          role: formRole,
          serie: formSerie,
          status: formStatus,
          date: dateStr,
          tests: 0,
        };
        setUsers([...users, newUser]);
        toast({ title: t("admin.pages.users.addNew"), description: `${formName} ${t("admin.pages.users.addNew").toLowerCase()}` });
      }
      setDialogOpen(false);
    } catch (error) {
      toast({
        title: t("common.error"),
        description: error instanceof Error ? error.message : "Impossible de sauvegarder l'utilisateur",
        variant: "destructive"
      });
      console.error('Error saving user:', error);
    }
  };

  const handleDelete = async () => {
    if (deletingUserId !== null) {
      try {
        await admin.deleteUser(deletingUserId);
        const user = users.find((u) => u.id === deletingUserId);
        setUsers(users.filter((u) => u.id !== deletingUserId));
        toast({ title: t("admin.pages.users.deleteUser"), description: `${user?.name} ${t("admin.pages.users.deleteUser").toLowerCase()}`, variant: "destructive" });
        setDeleteDialogOpen(false);
        setDeletingUserId(null);
      } catch (error) {
        toast({
          title: t("common.error"),
          description: error instanceof Error ? error.message : "Impossible de supprimer l'utilisateur",
          variant: "destructive"
        });
        console.error('Error deleting user:', error);
      }
    }
  };

  const statusBadge = (status: string) => {
    const styles: Record<string, string> = {
      Actif: "bg-success/10 text-success",
      Inactif: "bg-muted text-muted-foreground",
      Suspendu: "bg-warning/10 text-warning",
    };
    return styles[status] || "bg-muted text-muted-foreground";
  };

  if (loading) {
    return (
      <AdminLayout>
        <div className="flex items-center justify-center min-h-screen">
          <p className="text-muted-foreground">{t("common.loading")}</p>
        </div>
      </AdminLayout>
    );
  }

  return (
    <AdminLayout>
      <div className="animate-fade-in">
        <div className="mb-8 flex flex-col sm:flex-row sm:items-center gap-4">
          {/* Left - Search inputs */}
          <div className="flex flex-col sm:flex-row gap-3 flex-1 sm:items-center">
            <div className="relative flex-1">
              <Search className="absolute left-3 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground" />
              <Input placeholder={t("admin.pages.users.searchPlaceholder")} value={search} onChange={(e) => setSearch(e.target.value)} className="pl-9 h-10" />
            </div>
            <Select value={statusFilter} onValueChange={setStatusFilter}>
              <SelectTrigger className="w-full sm:w-[160px] h-10">
                <Filter className="h-4 w-4 mr-2 text-muted-foreground" />
                <SelectValue placeholder={t("admin.status")} />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">{t("admin.pages.users.all")}</SelectItem>
                <SelectItem value="Actif">{t("admin.pages.users.active")}</SelectItem>
                <SelectItem value="Inactif">{t("admin.pages.users.inactive")}</SelectItem>
                <SelectItem value="Suspendu">{t("admin.pages.users.suspended")}</SelectItem>
              </SelectContent>
            </Select>
          </div>

          {/* Right - Counter & Buttons */}
          <div className="flex items-center gap-3 sm:justify-end flex-wrap">
            <div className="hidden sm:flex items-center px-3 py-1 rounded-lg bg-accent/30 border border-accent/50">
              <span className="text-xs font-medium text-muted-foreground">
                {users.length} {t("admin.pages.users.noResults").toLowerCase()}
              </span>
            </div>
            <div className="flex gap-2">
              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button variant="outline" size="sm">
                    <Download className="h-4 w-4 mr-1" /> {t("common.export")}
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="end">
                  <DropdownMenuItem onClick={handleExportCSV}>
                    {t("admin.pages.users.exportCSV")}
                  </DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>
              <Button size="sm" onClick={openAddDialog}>
                <UserPlus className="h-4 w-4 mr-1" /> {t("admin.pages.users.addNew")}
              </Button>
            </div>
          </div>
        </div>

        <div className="rounded-xl border bg-card shadow-card overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead>
                <tr className="border-b text-left text-xs font-semibold uppercase tracking-wider text-muted-foreground">
                  <th className="p-4">{t("admin.name")}</th>
                  <th className="p-4">{t("admin.pages.users.role")}</th>
                  <th className="p-4">{t("admin.pages.users.serie")}</th>
                  <th className="p-4">{t("admin.pages.users.tests")}</th>
                  <th className="p-4">{t("admin.date")}</th>
                  <th className="p-4">{t("admin.status")}</th>
                  <th className="p-4 text-right">{t("common.edit")}</th>
                </tr>
              </thead>
              <tbody>
                {filtered.map((user) => (
                  <tr key={user.id} className="border-b last:border-0 hover:bg-accent/30 transition-colors">
                    <td className="p-4">
                      <div className="flex items-center gap-3">
                        <div className="flex h-9 w-9 items-center justify-center rounded-full bg-accent text-xs font-semibold text-accent-foreground">
                          {user.name.charAt(0)}
                        </div>
                        <div>
                          <p className="text-sm font-medium">{user.name}</p>
                          <p className="text-xs text-muted-foreground">{user.email}</p>
                        </div>
                      </div>
                    </td>
                    <td className="p-4 text-sm">{user.role}</td>
                    <td className="p-4 text-sm text-muted-foreground">{user.serie}</td>
                    <td className="p-4 text-sm font-medium">{user.tests}</td>
                    <td className="p-4 text-sm text-muted-foreground">{user.date}</td>
                    <td className="p-4">
                      <span className={`rounded-full px-2.5 py-0.5 text-xs font-medium ${statusBadge(user.status)}`}>
                        {user.status}
                      </span>
                    </td>
                    <td className="p-4 text-right">
                      <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                          <Button variant="ghost" size="icon" className="h-8 w-8">
                            <MoreHorizontal className="h-4 w-4" />
                          </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                          <DropdownMenuItem onClick={() => { setViewingUser(user); setViewDialogOpen(true); }}>
                            <Eye className="h-4 w-4 mr-2" /> {t("admin.pages.users.viewDetails")}
                          </DropdownMenuItem>
                          <DropdownMenuItem onClick={() => openEditDialog(user)}>
                            <Pencil className="h-4 w-4 mr-2" /> {t("admin.pages.users.editAction")}
                          </DropdownMenuItem>
                          <DropdownMenuItem className="text-destructive" onClick={() => { setDeletingUserId(user.id); setDeleteDialogOpen(true); }}>
                            <Trash2 className="h-4 w-4 mr-2" /> {t("admin.pages.users.deleteAction")}
                          </DropdownMenuItem>
                        </DropdownMenuContent>
                      </DropdownMenu>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          {filtered.length === 0 && (
            <div className="p-8 text-center text-muted-foreground">
              <Users className="h-10 w-10 mx-auto mb-2 opacity-40" />
              <p>{t("admin.pages.users.noResults")}</p>
            </div>
          )}
        </div>

        {/* Add/Edit Dialog */}
        <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
          <DialogContent className="max-w-lg">
            <DialogHeader>
              <DialogTitle>{editingUser ? t("admin.pages.users.editUser") : t("admin.pages.users.addUser")}</DialogTitle>
            </DialogHeader>
            <div className="space-y-4 py-2">
              <div className="grid gap-4 sm:grid-cols-2">
                <div className="space-y-1.5">
                  <Label>{t("admin.pages.users.formName")}</Label>
                  <Input value={formName} onChange={(e) => setFormName(e.target.value)} placeholder="ex: Mialy Rakoto" />
                </div>
                <div className="space-y-1.5">
                  <Label>{t("admin.email")}</Label>
                  <Input type="email" value={formEmail} onChange={(e) => setFormEmail(e.target.value)} placeholder="ex: mialy@email.mg" />
                </div>
              </div>
              <div className="grid gap-4 sm:grid-cols-3">
                <div className="space-y-1.5">
                  <Label>{t("admin.pages.users.formRole")}</Label>
                  <Select value={formRole} onValueChange={(value) => setFormRole(value as "Étudiant" | "Admin")}>
                    <SelectTrigger><SelectValue /></SelectTrigger>
                    <SelectContent>
                      <SelectItem value="Étudiant">{t("admin.pages.users.student")}</SelectItem>
                      <SelectItem value="Admin">{t("admin.pages.users.admin")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-1.5">
                  <Label>{t("admin.pages.users.formSerie")}</Label>
                  <Select value={formSerie} onValueChange={(value) => setFormSerie(value as "Série C" | "Série D" | "Série A" | "Tech." | "-")}>
                    <SelectTrigger><SelectValue /></SelectTrigger>
                    <SelectContent>
                      <SelectItem value="Série C">Série C</SelectItem>
                      <SelectItem value="Série D">Série D</SelectItem>
                      <SelectItem value="Série A">Série A</SelectItem>
                      <SelectItem value="Tech.">Tech.</SelectItem>
                      <SelectItem value="-">N/A</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-1.5">
                  <Label>{t("admin.pages.users.formStatus")}</Label>
                  <Select value={formStatus} onValueChange={(value) => setFormStatus(value as "Actif" | "Inactif" | "Suspendu")}>
                    <SelectTrigger><SelectValue /></SelectTrigger>
                    <SelectContent>
                      <SelectItem value="Actif">{t("admin.pages.users.active")}</SelectItem>
                      <SelectItem value="Inactif">{t("admin.pages.users.inactive")}</SelectItem>
                      <SelectItem value="Suspendu">{t("admin.pages.users.suspended")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </div>
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setDialogOpen(false)}>{t("admin.pages.users.cancel")}</Button>
              <Button onClick={handleSave} disabled={!formName.trim() || !formEmail.trim()}>
                {editingUser ? t("admin.pages.users.save") : t("admin.pages.users.addNew")}
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* View Dialog */}
        <Dialog open={viewDialogOpen} onOpenChange={setViewDialogOpen}>
          <DialogContent className="max-w-md">
            <DialogHeader>
              <DialogTitle>{t("admin.pages.users.viewDetails")}</DialogTitle>
            </DialogHeader>
            {viewingUser && (
              <div className="space-y-4 py-2">
                <div className="flex items-center gap-4">
                  <div className="flex h-14 w-14 items-center justify-center rounded-full bg-primary/10 text-lg font-bold text-primary">
                    {viewingUser.name.charAt(0)}
                  </div>
                  <div>
                    <p className="font-semibold text-lg">{viewingUser.name}</p>
                    <p className="text-sm text-muted-foreground">{viewingUser.email}</p>
                  </div>
                </div>
                <div className="grid grid-cols-2 gap-3">
                  <div className="rounded-lg border p-3">
                    <p className="text-xs text-muted-foreground">{t("admin.pages.users.role")}</p>
                    <p className="font-medium text-sm">{viewingUser.role}</p>
                  </div>
                  <div className="rounded-lg border p-3">
                    <p className="text-xs text-muted-foreground">{t("admin.pages.users.serie")}</p>
                    <p className="font-medium text-sm">{viewingUser.serie}</p>
                  </div>
                  <div className="rounded-lg border p-3">
                    <p className="text-xs text-muted-foreground">{t("admin.pages.users.tests")}</p>
                    <p className="font-medium text-sm">{viewingUser.tests}</p>
                  </div>
                  <div className="rounded-lg border p-3">
                    <p className="text-xs text-muted-foreground">{t("admin.status")}</p>
                    <span className={`rounded-full px-2.5 py-0.5 text-xs font-medium ${statusBadge(viewingUser.status)}`}>
                      {viewingUser.status}
                    </span>
                  </div>
                </div>
                <div className="rounded-lg border p-3">
                  <p className="text-xs text-muted-foreground">{t("admin.date")}</p>
                  <p className="font-medium text-sm">{viewingUser.date}</p>
                </div>
              </div>
            )}
          </DialogContent>
        </Dialog>

        {/* Delete Confirmation */}
        <AlertDialog open={deleteDialogOpen} onOpenChange={setDeleteDialogOpen}>
          <AlertDialogContent>
            <AlertDialogHeader>
              <AlertDialogTitle>{t("admin.pages.users.deleteConfirmTitle")}</AlertDialogTitle>
              <AlertDialogDescription>
                {t("admin.pages.users.confirmDelete")}
              </AlertDialogDescription>
            </AlertDialogHeader>
            <AlertDialogFooter>
              <AlertDialogCancel>{t("admin.pages.users.cancel")}</AlertDialogCancel>
              <AlertDialogAction onClick={handleDelete} className="bg-destructive text-destructive-foreground hover:bg-destructive/90">
                {t("admin.pages.users.delete")}
              </AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>
      </div>
    </AdminLayout>
  );
};

export default AdminUsers;
