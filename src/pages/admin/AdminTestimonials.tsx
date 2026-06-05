import AdminLayout from "@/components/AdminLayout";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Badge } from "@/components/ui/badge";
import { Textarea } from "@/components/ui/textarea";
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
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import {
  MessageSquare,
  Plus,
  MoreHorizontal,
  Eye,
  Pencil,
  Trash2,
  Star,
  CheckCircle2,
  XCircle,
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
import type { Testimonial } from "@/types";

const initialTestimonials: Testimonial[] = [
  {
    id: 1,
    student_name: "Mialy Rakoto",
    student_serie: "Série C",
    student_photo: "M",
    university_name: "Université d'Antananarivo",
    course_name: "Informatique",
    text: "Une excellente formation qui m'a bien préparée pour ma carrière en développement logiciel.",
    rating: 5,
    status: "Approuvé",
    date: "01/01/2024",
  },
  {
    id: 2,
    student_name: "Jean Dupont",
    student_serie: "Série D",
    student_photo: "J",
    university_name: "Université de Mahajanga",
    course_name: "Génie Civil",
    text: "Les professeurs sont très compétents et les ressources disponibles sont excellentes.",
    rating: 4,
    status: "Approuvé",
    date: "05/01/2024",
  },
];

const AdminTestimonials = () => {
  const { t } = useTranslation();
  const [testimonials, setTestimonials] = useState<Testimonial[]>([...initialTestimonials]);
  const [dialogOpen, setDialogOpen] = useState(false);
  const [viewDialogOpen, setViewDialogOpen] = useState(false);
  const [deleteDialogOpen, setDeleteDialogOpen] = useState(false);
  const [editingItem, setEditingItem] = useState<Testimonial | null>(null);
  const [viewingItem, setViewingItem] = useState<Testimonial | null>(null);
  const [deletingId, setDeletingId] = useState<number | null>(null);
  const [loading, setLoading] = useState(true);
  const { toast } = useToast();

  useEffect(() => {
    const fetchTestimonials = async () => {
      try {
        setLoading(true);
        const response = await admin.getTestimonials(1, 100) as any;
        const data = (response?.testimonials || response?.data || []) as Testimonial[];
        if (Array.isArray(data)) {
          setTestimonials(data);
        }
      } catch (error) {
        // If API fails, use initial data
        setTestimonials([...initialTestimonials]);
        console.error('Error fetching testimonials:', error);
      } finally {
        setLoading(false);
      }
    };

    fetchTestimonials();
  }, []);

  // Form
  const [formStudentName, setFormStudentName] = useState("");
  const [formUniversityName, setFormUniversityName] = useState("");
  const [formCourseName, setFormCourseName] = useState("");
  const [formText, setFormText] = useState("");
  const [formRating, setFormRating] = useState("5");
  const [formStatus, setFormStatus] = useState<"Approuvé" | "En attente" | "Rejeté">("En attente");

  const statusStyles: Record<string, string> = {
    "Approuvé": "bg-success/10 text-success",
    "En attente": "bg-warning/10 text-warning",
    "Rejeté": "bg-destructive/10 text-destructive",
  };

  const handleExportCSV = () => {
    const data = testimonials.map(t => ({
      ID: t.id,
      'Nom Étudiant': t.student_name,
      'Série Bac': t.student_serie || '',
      Université: t.university_name,
      Filière: t.course_name,
      Note: t.rating,
      Statut: t.status,
      Texte: t.text,
      Date: t.date,
    }));
    downloadCSV(data, `temoignages-${new Date().toLocaleDateString('fr-FR')}.csv`);
    toast({ title: t("common.success"), description: `${testimonials.length} ${t("admin.pages.testimonials.noResults").toLowerCase()}` });
  };

  const openAddDialog = () => {
    setEditingItem(null);
    setFormStudentName(""); setFormUniversityName(""); setFormCourseName(""); setFormText("");
    setFormRating("5"); setFormStatus("En attente");
    setDialogOpen(true);
  };

  const openEditDialog = (t: Testimonial) => {
    setEditingItem(t);
    setFormStudentName(t.student_name); setFormUniversityName(t.university_name);
    setFormCourseName(t.course_name); setFormText(t.text);
    setFormRating(String(t.rating)); setFormStatus(t.status);
    setDialogOpen(true);
  };

  const handleSave = async () => {
    try {
      const now = new Date();
      const dateStr = `${now.getDate().toString().padStart(2, "0")}/${(now.getMonth() + 1).toString().padStart(2, "0")}/${now.getFullYear()}`;

      if (editingItem) {
        await admin.updateTestimonial(editingItem.id, {
          student_name: formStudentName,
          university_name: formUniversityName,
          course_name: formCourseName,
          text: formText,
          rating: parseInt(formRating),
          status: formStatus,
        });
        setTestimonials(testimonials.map((t) => (t.id === editingItem.id ? {
          ...t,
          student_name: formStudentName,
          university_name: formUniversityName,
          course_name: formCourseName,
          text: formText,
          rating: parseInt(formRating),
          status: formStatus,
        } : t)));
        toast({ title: t("admin.pages.testimonials.approved"), description: `Témoignage de ${formStudentName} mis à jour.` });
      } else {
        await admin.createTestimonial({
          student_name: formStudentName,
          student_serie: "Série C",
          university_name: formUniversityName,
          course_name: formCourseName,
          text: formText,
          rating: parseInt(formRating),
          status: formStatus,
        });
        setTestimonials([...testimonials, {
          id: Math.max(...testimonials.map(t => t.id), 0) + 1,
          student_name: formStudentName,
          student_serie: "Série C",
          student_photo: formStudentName.charAt(0),
          university_name: formUniversityName,
          course_name: formCourseName,
          text: formText,
          rating: parseInt(formRating),
          status: formStatus,
          date: dateStr,
        }]);
        toast({ title: t("admin.pages.testimonials.approved"), description: `Témoignage de ${formStudentName} ajouté avec succès.` });
      }
      setDialogOpen(false);
    } catch (error) {
      toast({ title: t("common.error"), description: "Impossible de sauvegarder le témoignage", variant: "destructive" });
      console.error('Error saving testimonial:', error);
    }
  };

  const handleDelete = async () => {
    if (deletingId !== null) {
      try {
        await admin.deleteTestimonial(deletingId);
        setTestimonials(testimonials.filter((t) => t.id !== deletingId));
        toast({ title: t("admin.pages.testimonials.deleteTestimonial"), variant: "destructive" });
      } catch (error) {
        toast({ title: t("common.error"), description: "Impossible de supprimer le témoignage", variant: "destructive" });
        console.error('Error deleting testimonial:', error);
      } finally {
        setDeleteDialogOpen(false);
        setDeletingId(null);
      }
    }
  };

  const handleApprove = async (id: number) => {
    try {
      await admin.approveTestimonial(id);
      setTestimonials(testimonials.map((t) => t.id === id ? { ...t, status: "Approuvé" } : t));
      toast({ title: t("admin.pages.testimonials.approveTestimonial"), description: "Le témoignage est maintenant visible." });
    } catch (error) {
      toast({ title: t("common.error"), description: "Impossible d'approuver le témoignage", variant: "destructive" });
      console.error('Error approving testimonial:', error);
    }
  };

  const handleReject = async (id: number) => {
    try {
      await admin.rejectTestimonial(id);
      setTestimonials(testimonials.map((t) => t.id === id ? { ...t, status: "Rejeté" } : t));
      toast({ title: t("admin.pages.testimonials.rejectTestimonial"), variant: "destructive" });
    } catch (error) {
      toast({ title: t("common.error"), description: "Impossible de rejeter le témoignage", variant: "destructive" });
      console.error('Error rejecting testimonial:', error);
    }
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
        <div className="mb-8 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
          <div>
            <h1 className="text-3xl font-bold">{t("admin.pages.testimonials.title")}</h1>
            <p className="mt-1 text-muted-foreground">{t("admin.pages.testimonials.description")}</p>
          </div>
          <div className="flex gap-2">
            <DropdownMenu>
              <DropdownMenuTrigger asChild>
                <Button size="sm" variant="outline">
                  <Plus className="h-4 w-4 mr-1" /> {t("common.filter")}
                </Button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end">
                <DropdownMenuItem onClick={handleExportCSV}>
                  {t("admin.pages.testimonials.exportCSV")}
                </DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
            <Button size="sm" onClick={openAddDialog}>
              <Plus className="h-4 w-4 mr-1" /> {t("admin.pages.testimonials.approved")}
            </Button>
          </div>
        </div>

        {/* Quick stats */}
        <div className="mb-8 grid gap-4 sm:grid-cols-3">
          <div className="rounded-xl border bg-card p-4 shadow-card flex items-center gap-3">
            <div className="flex h-9 w-9 items-center justify-center rounded-lg bg-success/10">
              <CheckCircle2 className="h-4 w-4 text-success" />
            </div>
            <div>
              <p className="text-xl font-bold">{testimonials.filter(t => t.status === "Approuvé").length}</p>
              <p className="text-xs text-muted-foreground">Approuvés</p>
            </div>
          </div>
          <div className="rounded-xl border bg-card p-4 shadow-card flex items-center gap-3">
            <div className="flex h-9 w-9 items-center justify-center rounded-lg bg-warning/10">
              <MessageSquare className="h-4 w-4 text-warning" />
            </div>
            <div>
              <p className="text-xl font-bold">{testimonials.filter(t => t.status === "En attente").length}</p>
              <p className="text-xs text-muted-foreground">En attente</p>
            </div>
          </div>
          <div className="rounded-xl border bg-card p-4 shadow-card flex items-center gap-3">
            <div className="flex h-9 w-9 items-center justify-center rounded-lg bg-destructive/10">
              <XCircle className="h-4 w-4 text-destructive" />
            </div>
            <div>
              <p className="text-xl font-bold">{testimonials.filter(t => t.status === "Rejeté").length}</p>
              <p className="text-xs text-muted-foreground">Rejetés</p>
            </div>
          </div>
        </div>

        {/* Testimonials list */}
        <div className="space-y-4">
          {testimonials.map((testimonial) => (
            <div key={testimonial.id} className="rounded-xl border bg-card p-5 shadow-card">
              <div className="flex items-start justify-between gap-4">
                <div className="flex items-start gap-4 flex-1">
                  <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-accent text-sm font-semibold text-accent-foreground">
                    {testimonial.student_name.charAt(0)}
                  </div>
                  <div className="flex-1">
                    <div className="flex flex-wrap items-center gap-2 mb-1">
                      <h3 className="font-semibold text-sm">{testimonial.student_name}</h3>
                      <span className="text-xs text-muted-foreground">— {testimonial.course_name} @ {testimonial.university_name}</span>
                      <Badge className={`text-[10px] ${statusStyles[testimonial.status]}`} variant="outline">{testimonial.status}</Badge>
                    </div>
                    <div className="flex items-center gap-0.5 mb-2">
                      {Array.from({ length: 5 }).map((_, i) => (
                        <Star key={i} className={`h-3.5 w-3.5 ${i < testimonial.rating ? "fill-warning text-warning" : "text-muted"}`} />
                      ))}
                    </div>
                    <p className="text-sm text-muted-foreground leading-relaxed">"{testimonial.text}"</p>
                    <p className="text-xs text-muted-foreground mt-2">{testimonial.date}</p>
                  </div>
                </div>
                <div className="flex items-center gap-1">
                  {testimonial.status === "En attente" && (
                    <>
                      <Button variant="ghost" size="icon" className="h-8 w-8 text-success hover:text-success hover:bg-success/10" onClick={() => handleApprove(testimonial.id)}>
                        <CheckCircle2 className="h-4 w-4" />
                      </Button>
                      <Button variant="ghost" size="icon" className="h-8 w-8 text-destructive hover:text-destructive hover:bg-destructive/10" onClick={() => handleReject(testimonial.id)}>
                        <XCircle className="h-4 w-4" />
                      </Button>
                    </>
                  )}
                  <DropdownMenu>
                    <DropdownMenuTrigger asChild>
                      <Button variant="ghost" size="icon" className="h-8 w-8">
                        <MoreHorizontal className="h-4 w-4" />
                      </Button>
                    </DropdownMenuTrigger>
                    <DropdownMenuContent align="end">
                      <DropdownMenuItem onClick={() => { setViewingItem(testimonial); setViewDialogOpen(true); }}>
                        <Eye className="h-4 w-4 mr-2" /> {t("admin.pages.testimonials.viewDetails")}
                      </DropdownMenuItem>
                      <DropdownMenuItem onClick={() => openEditDialog(testimonial)}>
                        <Pencil className="h-4 w-4 mr-2" /> {t("admin.pages.testimonials.editAction")}
                      </DropdownMenuItem>
                      <DropdownMenuItem className="text-destructive" onClick={() => { setDeletingId(testimonial.id); setDeleteDialogOpen(true); }}>
                        <Trash2 className="h-4 w-4 mr-2" /> {t("admin.pages.testimonials.deleteAction")}
                      </DropdownMenuItem>
                    </DropdownMenuContent>
                  </DropdownMenu>
                </div>
              </div>
            </div>
          ))}
        </div>

        {/* Add/Edit Dialog */}
        <Dialog open={dialogOpen} onOpenChange={setDialogOpen}>
          <DialogContent className="max-w-lg">
            <DialogHeader>
              <DialogTitle>{editingItem ? t("admin.pages.testimonials.approved") : t("admin.pages.testimonials.approved")}</DialogTitle>
            </DialogHeader>
            <div className="space-y-4 py-2">
              <div className="grid gap-4 sm:grid-cols-2">
                <div className="space-y-1.5">
                  <Label>{t("admin.name")}</Label>
                  <Input value={formStudentName} onChange={(e) => setFormStudentName(e.target.value)} placeholder="ex: Mialy Rakoto" />
                </div>
                <div className="space-y-1.5">
                  <Label>{t("admin.pages.universities.title").split(' ')[1]}</Label>
                  <Input value={formUniversityName} onChange={(e) => setFormUniversityName(e.target.value)} placeholder="ex: Université d'Antananarivo" />
                </div>
              </div>
              <div className="space-y-1.5">
                <Label>{t("admin.pages.filieres.title").split(' ')[1]}</Label>
                <Input value={formCourseName} onChange={(e) => setFormCourseName(e.target.value)} placeholder="ex: Informatique" />
              </div>
              <div className="space-y-1.5">
                <Label>{t("admin.pages.testimonials.description")}</Label>
                <Textarea value={formText} onChange={(e) => setFormText(e.target.value)} placeholder="Le témoignage..." className="min-h-[80px]" />
              </div>
              <div className="grid gap-4 sm:grid-cols-2">
                <div className="space-y-1.5">
                  <Label>{t("admin.pages.testimonials.rating")}</Label>
                  <Select value={formRating} onValueChange={setFormRating}>
                    <SelectTrigger><SelectValue /></SelectTrigger>
                    <SelectContent>
                      {[1, 2, 3, 4, 5].map((n) => <SelectItem key={n} value={String(n)}>{n} étoile{n > 1 ? "s" : ""}</SelectItem>)}
                    </SelectContent>
                  </Select>
                </div>
                <div className="space-y-1.5">
                  <Label>{t("admin.status")}</Label>
                  <Select value={formStatus} onValueChange={(value) => setFormStatus(value as "Approuvé" | "En attente" | "Rejeté")}>
                    <SelectTrigger><SelectValue /></SelectTrigger>
                    <SelectContent>
                      <SelectItem value="En attente">{t("admin.pages.testimonials.pending")}</SelectItem>
                      <SelectItem value="Approuvé">{t("admin.pages.testimonials.approved")}</SelectItem>
                      <SelectItem value="Rejeté">{t("admin.pages.testimonials.rejected")}</SelectItem>
                    </SelectContent>
                  </Select>
                </div>
              </div>
            </div>
            <DialogFooter>
              <Button variant="outline" onClick={() => setDialogOpen(false)}>{t("admin.pages.testimonials.cancel")}</Button>
              <Button onClick={handleSave} disabled={!formStudentName.trim() || !formText.trim() || !formUniversityName.trim()}>
                {editingItem ? t("admin.pages.testimonials.save") : t("admin.pages.testimonials.approved")}
              </Button>
            </DialogFooter>
          </DialogContent>
        </Dialog>

        {/* View Dialog */}
        <Dialog open={viewDialogOpen} onOpenChange={setViewDialogOpen}>
          <DialogContent className="max-w-md">
            <DialogHeader>
              <DialogTitle>{t("admin.pages.testimonials.viewDetails")}</DialogTitle>
            </DialogHeader>
            {viewingItem && (
              <div className="space-y-4 py-2">
                <div className="flex items-center gap-3">
                  <div className="flex h-12 w-12 items-center justify-center rounded-full bg-primary/10 text-lg font-bold text-primary">
                    {viewingItem.student_name.charAt(0)}
                  </div>
                  <div>
                    <p className="font-semibold">{viewingItem.student_name}</p>
                    <p className="text-sm text-muted-foreground">{viewingItem.course_name}</p>
                  </div>
                </div>
                <div className="text-sm text-muted-foreground">
                  <p><strong>Université :</strong> {viewingItem.university_name}</p>
                </div>
                <div className="flex items-center gap-0.5">
                  {Array.from({ length: 5 }).map((_, i) => (
                    <Star key={i} className={`h-4 w-4 ${i < viewingItem.rating ? "fill-warning text-warning" : "text-muted"}`} />
                  ))}
                </div>
                <p className="text-sm leading-relaxed border rounded-lg p-3 bg-muted/30">"{viewingItem.text}"</p>
                <div className="flex justify-between text-xs text-muted-foreground">
                  <span>Date : {viewingItem.date}</span>
                  <Badge className={`${statusStyles[viewingItem.status]}`} variant="outline">{viewingItem.status}</Badge>
                </div>
              </div>
            )}
          </DialogContent>
        </Dialog>

        {/* Delete Confirmation */}
        <AlertDialog open={deleteDialogOpen} onOpenChange={setDeleteDialogOpen}>
          <AlertDialogContent>
            <AlertDialogHeader>
              <AlertDialogTitle>{t("admin.pages.testimonials.deleteTestimonial")} ?</AlertDialogTitle>
              <AlertDialogDescription>Cette action est irréversible.</AlertDialogDescription>
            </AlertDialogHeader>
            <AlertDialogFooter>
              <AlertDialogCancel>{t("admin.pages.testimonials.cancel")}</AlertDialogCancel>
              <AlertDialogAction onClick={handleDelete} className="bg-destructive text-destructive-foreground hover:bg-destructive/90">
                {t("admin.pages.testimonials.deleteTestimonial")}
              </AlertDialogAction>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialog>
      </div>
    </AdminLayout>
  );
};

export default AdminTestimonials;
