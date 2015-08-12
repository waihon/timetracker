class Usermailer < ApplicationMailer
  default from: "yewserwan@gmail.com"

  def workcreated_email(work)
    @work = work
    mail(to: work.project.owner.email, subject: "Work Item Posted")
  end

  def project_updated_email(project)
    @project = project
    mail(to: project.owner.email, subject: "Project Updated")
  end
end
